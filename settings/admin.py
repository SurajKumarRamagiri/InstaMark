from django.contrib import admin
from .models import SystemSettings
from .forms import SystemSettingsForm

@admin.register(SystemSettings)
class SystemSettingsAdmin(admin.ModelAdmin):
    form = SystemSettingsForm
    list_display = ['attendance_time_limit', 'face_recognition_threshold']
