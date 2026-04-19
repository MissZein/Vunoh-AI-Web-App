# Vunoh-AI-Web-App
Vunoh Global AI Assistant
Empowering the Diaspora, Securing the Home.
📌 Project Overview
This application is a specialized AI-powered assistant designed to help Kenyans living abroad manage critical tasks back home. It bridges the gap between informal, unreliable communication channels and structured, professional task management.The system extracts user intent, assesses risk based on the Kenyan context, generates actionable steps, and produces platform-specific communication for WhatsApp, Email, and SMS.

🛠️ Technology Stack

Backend: Django (Python) 

Frontend:HTML5, CSS3, and Vanilla JavaScript 

Database: SQLite 

AI Brain: Gemini 2.5-Flash API

🚀 Setup Instructions
Clone the Repo: git clone "link"

Install Dependencies: pip install -r requirements.txt

Setup Environment: Create a .env file and add GEMINI_API_KEY=your_key_here.

Database Migration: * python manage.py makemigrations

python manage.py migrate

Run Server: python manage.py runserver

Access Admin: Create a superuser (python manage.py createsuperuser) and visit /admin/ to view the task audit trail.

🧠 Decisions I Made and Why 
1. AI Tools Used 
Gemini 2.5-Flash: Used as the core "Brain" for intent extraction, risk scoring, and multi-format message generation.
Gemini Collaboration: Used during development to troubleshoot Django middleware issues.
Cursor: Used to create the UI of the website to personalise it
2. System Prompt Design What was included: 
* Structured JSON Enforcement: I explicitly instructed the AI to return only valid JSON to ensure the backend could parse the data without errors.Kenyan Context: I included specific locations (e.g., Syokimau, Westlands) and currency (KES) to ground the AI's logic in local reality.What was excluded: 
* I excluded conversational "chatter" from the AI's internal processing. I wanted raw data for the database, not a "friendly" chat response, to keep the system efficient.
3. Overriding the AI The Decision: 
The AI initially suggested a generic risk score of 1–10.
My Reasoning: I overrode this to implement a weighted logic. I forced the AI to prioritize Land Title Verification and High-Value Transfers (> 50,000 KES) as high-risk, regardless of the user's tone. 
I decided that "Urgency" should only be a risk multiplier if the "Amount" was also high, to avoid over-flagging simple errands.
The Why: In the Kenyan context, land fraud is a significantly higher risk than a "cleaning errand" in Westlands, even if the cleaning errand is "urgent". I decided that Vunoh Global’s reputation depends on protecting diaspora assets; therefore, "Asset Type" must carry more weight in the risk score than the user's emotional "Urgency".
4. Challenges & Resolutions The Issue: 
I encountered a persistent 401 Unauthorized error and Unexpected token '<' when trying to use the standard Google Generative AI Python SDK.
Resolution: I realized the SDK was conflicting with the environment. 
I resolved this by pivoting to a Direct REST API call using the requests library. I manually configured the x-goog-api-key headers, which bypassed the SDK bug and provided a more stable connection to the model.

⚖️ Risk Scoring Logic 
Our risk engine evaluates requests based on three primary pillars:
1. Financial Value: Any transfer exceeding 50,000 KES is flagged as Elevated Risk.
2. Asset Sensitivity: Document verification involving Land Titles or Property Deeds is automatically assigned a High Risk score due to the prevalence of land fraud.
3. Urgency vs. Clarity: "Urgent" requests that lack specific recipient names or locations are flagged for manual review to prevent impulsive or fraudulent transactions.

📊 Database Schema 
The included vunoh_db_dump.sql contains:
1. Table: tasks_task (Stores unique task codes, intents, entities, and risk scores).
2. Messages: Dedicated fields for WhatsApp, Email, and SMS formats.
3. Assignments: Logical mapping to Finance, Legal, or Operations teams

Live hosted link
https://vunoh-ai-web-app.onrender.com