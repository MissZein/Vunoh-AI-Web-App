import os
import json
import google.generativeai as genai
from django.conf import settings
from dotenv import load_dotenv

load_dotenv()
genai.configure(api_key=os.getenv("GEMINI_API_KEY"), transport='rest')

def process_task_with_ai(user_input):

    # Use the top model from your list
    model = genai.GenerativeModel('models/gemini-2.5-flash')
    
    system_prompt = """
    You are an AI assistant for Vunoh Global, helping Kenyan diaspora manage tasks back home.
    Analyze the user's request and return ONLY a valid JSON object with these keys:
    1. "intent": One of (send_money, hire_service, verify_document)
    2. "entities": A dictionary of details (e.g., amount, location, service_type)
    3. "risk_score": An integer 1-100 based on financial/legal impact.
    4. "assigned_team": One of (Finance, Operations, Legal)
    5. "process_steps": A list of 3-4 logical steps to complete this task in Kenya.
    6. "whatsapp": A casual confirmation message.
    7. "email": A formal professional confirmation.
    8. "sms": A short, urgent update.

    Context for Risk:
    - Verifying land/ID or large money transfers (>50k KES) = High Risk (>70)
    - Hiring professional services (Lawyers) = Medium Risk (40-60)
    - Small errands or cleaners = Low Risk (<30)
    """

    response = model.generate_content(f"{system_prompt}\n\nUser Request: {user_input}")
    
    # Clean the response to ensure it's valid JSON
    clean_json = response.text.replace('```json', '').replace('```', '').strip()
    return json.loads(clean_json)