from django.shortcuts import render
from django.http import JsonResponse
from .services import process_task_with_ai
from .models import Task
import json
from django.views.decorators.csrf import csrf_exempt # Add this import

@csrf_exempt
def create_task(request):
    if request.method == "POST":
        # Get data from the frontend
        data = json.loads(request.body)
        user_text = data.get("request_text")
        print(f"DEBUG: Received text: {user_text}")
        
        # 1. Let the AI process it
        try:
            ai_data = process_task_with_ai(user_text)
            print(f"DEBUG: AI Output: {ai_data}") # Add this
        except Exception as e:
            print(f"DEBUG: ERROR calling AI: {e}") # Add this
            return JsonResponse({"error": str(e)}, status=500)
        
        # 2. Save to Database
        new_task = Task.objects.create(
            original_request=user_text,
            intent=ai_data['intent'],
            entities=ai_data['entities'],
            risk_score=ai_data['risk_score'],
            assigned_team=ai_data['assigned_team'],
            process_steps=ai_data['process_steps'],
            whatsapp_message=ai_data['whatsapp'],
            email_message=ai_data['email'],
            sms_message=ai_data['sms']
        )
        
        return JsonResponse({
            "status": "success", 
            "task_code": new_task.task_code,
            "ai_analysis": ai_data
        })

    return render(request, "tasks/index.html")


@csrf_exempt
def list_tasks(request):
    if request.method != "GET":
        return JsonResponse({"error": "Method not allowed"}, status=405)
    tasks = Task.objects.all().order_by("-created_at")
    data = [
        {
            "task_code": t.task_code,
            "intent": t.intent,
            "status": t.status,
            "risk_score": t.risk_score,
            "assigned_team": t.assigned_team,
            "created_at": t.created_at.isoformat(),
        }
        for t in tasks
    ]
    return JsonResponse({"tasks": data})


@csrf_exempt
def update_task_status(request):
    if request.method != "PATCH":
        return JsonResponse({"error": "Method not allowed"}, status=405)
    try:
        body = json.loads(request.body)
    except json.JSONDecodeError:
        return JsonResponse({"error": "Invalid JSON"}, status=400)
    task_code = body.get("task_code")
    status = body.get("status")
    valid = {c[0] for c in Task.STATUS_CHOICES}
    if not task_code or status not in valid:
        return JsonResponse({"error": "task_code and valid status required"}, status=400)
    try:
        task = Task.objects.get(task_code=task_code)
    except Task.DoesNotExist:
        return JsonResponse({"error": "Task not found"}, status=404)
    task.status = status
    task.save(update_fields=["status"])
    return JsonResponse(
        {
            "status": "success",
            "task_code": task.task_code,
            "new_status": task.status,
        }
    )