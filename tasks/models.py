from django.db import models
import uuid

class Task(models.Model):
    # 1. Unique Task Code for follow-up [cite: 53]
    task_code = models.CharField(max_length=12, unique=True, default=uuid.uuid4().hex[:8].upper())
    
    # 2. Raw User Input [cite: 27, 28]
    original_request = models.TextField()
    
    # 3. Extracted Data from AI [cite: 34, 35, 36]
    intent = models.CharField(max_length=50) # e.g., send_money
    entities = models.JSONField(default=dict) # Stores amount, recipient, etc.
    
    # 4. Risk & Assignment [cite: 43, 49, 72, 75]
    risk_score = models.IntegerField(default=0)
    assigned_team = models.CharField(max_length=50) # Finance, Legal, or Operations
    
    # 5. Step Generation [cite: 57, 58, 81]
    process_steps = models.JSONField(default=list) # Stores the sequence of steps
    
    # 6. Three-Format Messages [cite: 61, 62, 70]
    whatsapp_message = models.TextField()
    email_message = models.TextField()
    sms_message = models.TextField()
    
    # 7. Status and Metadata [cite: 55, 56, 77]
    STATUS_CHOICES = [
        ('Pending', 'Pending'),
        ('In Progress', 'In Progress'),
        ('Completed', 'Completed'),
    ]
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='Pending')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.intent} - {self.created_at.strftime('%Y-%m-%d')}"