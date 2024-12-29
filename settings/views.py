from django.shortcuts import render
from .models import SystemSettings

def get_system_settings():
    settings, created = SystemSettings.objects.get_or_create(id=1)  # Assuming only one settings object
    return settings

