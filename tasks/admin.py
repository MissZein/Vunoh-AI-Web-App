from django.contrib import admin
from .models import Task  # Import your Task model

admin.site.register(Task) # Register it so it appears in the dashboard