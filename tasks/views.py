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