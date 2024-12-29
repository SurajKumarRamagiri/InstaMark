from django.db import models

class SystemSettings(models.Model):
    # Example fields for the settings
    attendance_time_limit = models.PositiveIntegerField(default=30)  # time limit for full attendance in minutes
    face_recognition_threshold = models.FloatField(default=0.6)  # Threshold for face recognition similarity
    
    def __str__(self):
        return "System Settings"

    class Meta:
        verbose_name = "System Setting"
        verbose_name_plural = "System Settings"
