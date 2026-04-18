import json
import os
from pathlib import Path

from dotenv import load_dotenv
from google import genai

# Project root = folder containing manage.py
_PROJECT_ROOT = Path(__file__).resolve().parent.parent
_ENV_FILE = _PROJECT_ROOT / ".env"

load_dotenv(_ENV_FILE, override=True)

_api_key = os.getenv("GEMINI_API_KEY")
if not _api_key or not str(_api_key).strip():
    raise RuntimeError(
        "GEMINI_API_KEY is missing. Put it in .env next to manage.py: "
        "GEMINI_API_KEY=your_key — from https://aistudio.google.com/apikey"
    )

_api_key = str(_api_key).strip().strip('"').strip("'").lstrip("\ufeff")

# Gemini *Developer* API (AI Studio key). If GOOGLE_GENAI_USE_VERTEXAI=1 is set globally,
# some SDKs switch to Vertex + OAuth and AQ/AI Studio keys fail with ACCESS_TOKEN_TYPE_UNSUPPORTED.
os.environ.pop("GOOGLE_GENAI_USE_VERTEXAI", None)
os.environ["GEMINI_API_KEY"] = _api_key
# README: if both are set, GOOGLE_API_KEY wins — set only one to avoid surprises.
os.environ["GOOGLE_API_KEY"] = _api_key

# New unified SDK: HTTP + API key (works reliably with AQ-prefixed AI Studio keys).
_client = genai.Client(api_key=_api_key, vertexai=False)


def process_task_with_ai(user_input):
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

    full_prompt = f"{system_prompt}\n\nUser Request: {user_input}"

    response = _client.models.generate_content(
        model="gemini-2.5-flash",
        contents=full_prompt,
    )

    text = (response.text or "").strip()
    if not text:
        raise RuntimeError("Gemini returned empty text; check API key and model access.")

    clean_json = text.replace("```json", "").replace("```", "").strip()
    return json.loads(clean_json)
