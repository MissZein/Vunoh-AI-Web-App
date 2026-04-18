import json
import os
from pathlib import Path
import requests
from dotenv import load_dotenv

# 1. SETUP & PATHS (Keeping your robust logic)
_PROJECT_ROOT = Path(__file__).resolve().parent.parent
_ENV_FILE = _PROJECT_ROOT / ".env"

load_dotenv(_ENV_FILE, override=True)

def process_task_with_ai(user_input):
    # 2. KEY CLEANING (Crucial for preventing 401 errors)
    _api_key = os.getenv("GEMINI_API_KEY")
    if not _api_key or not str(_api_key).strip():
        raise RuntimeError(
        "GEMINI_API_KEY is missing. Check your .env file."
    )

# This removes invisible characters that often cause "Invalid Credentials"
    _api_key = str(_api_key).strip().strip('"').strip("'").lstrip("\ufeff")
    system_prompt = """
    You are an AI assistant for Vunoh Global, helping Kenyan diaspora manage tasks back home.
    Analyze the user's request and return ONLY a valid JSON object with these EXACT keys:
    "intent", "entities", "risk_score", "assigned_team", "process_steps", "whatsapp", "email", "sms"

    Context for Risk:
    - Verifying land/ID or large money transfers (>50k KES) = High Risk (>70)
    - Hiring professional services (Lawyers) = Medium Risk (40-60)
    - Small errands or cleaners = Low Risk (<30)
    """

    # 3. DIRECT API CALL (The fix for the 401 error)
    # Using the 2.5-flash model you specified
    url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent"
    
    # 2. Put the key in a SPECIAL header instead
    headers = {
        'Content-Type': 'application/json',
        'x-goog-api-key': _api_key  # <--- THIS IS THE FIX
    }
    
    payload = {
        "contents": [{
            "parts": [{
                "text": f"{system_prompt}\n\nUser Request: {user_input}"
            }]
        }]
    }

    # 3. Make the request (Notice we don't put the key in the URL anymore)
    response = requests.post(url, headers=headers, json=payload)
    
    if response.status_code == 200:
        result = response.json()
        try:
            # Extract text from the Google response structure
            raw_text = result['candidates'][0]['content']['parts'][0]['text']
            
            # 4. JSON CLEANING
            clean_json = raw_text.replace("```json", "").replace("```", "").strip()
            data = json.loads(clean_json)
        
            for field in ['whatsapp', 'email', 'sms']:
                val = data.get(field, "")
                if isinstance(val, dict):
                    # If AI sent a dict, pick the first value or join them
                    data[field] = " ".join(str(v) for v in val.values())
                elif isinstance(val, bool) or str(val).lower() in ['yes', 'no']:
                    # If AI was lazy, we add a fallback message
                    data[field] = f"Task update regarding your {data.get('intent')} request."
                else:
                    data[field] = str(val)
            
            return data
            
        except (KeyError, IndexError, json.JSONDecodeError) as e:
            print(f"DEBUG: Parsing Error: {e} | Raw Text: {raw_text}")
            raise Exception("AI response format was invalid.")
    else:
        # This will print the exact reason Google rejected the key in your terminal
        print(f"DEBUG: API Error Body: {response.text}")
        raise Exception(f"API Error {response.status_code}: {response.text}")