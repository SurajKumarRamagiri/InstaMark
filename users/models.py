# users/models.py
from django.db import models
from django.contrib.auth.models import User

class Department(models.Model):
    name = models.CharField(max_length=100, unique=True)
    
    def __str__(self):
        return self.name

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE,related_name='profile')
    department = models.ForeignKey(Department, on_delete=models.SET_NULL, null=True,blank=True)
    role = models.CharField(max_length=50, choices=[('superuser', 'Superuser'), ('staff', 'Staff'), ('regular', 'Regular User')])
    face_embedding = models.JSONField(null=True, blank=True)  # Storing face embeddings as a JSON field

    def __str__(self):
        return self.user.username


# # Custom User Model
# class User(AbstractUser):
#     ROLE_CHOICES = [
#         ('admin', 'Admin'),
#         ('manager', 'Manager'),
#         ('employee', 'Employee'),
#     ]
#     role = models.CharField(max_length=10, choices=ROLE_CHOICES, default='employee')

# # Manager's Team
# class ManagerTeam(models.Model):
#     manager = models.OneToOneField(User, on_delete=models.CASCADE, related_name='managed_team')
#     employees = models.ManyToManyField(User, related_name='team')

# Attendance Record
# class Attendance(models.Model):
#     user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='attendance')
#     date = models.DateField(auto_now_add=True)
#     status = models.CharField(max_length=10, choices=[('Present', 'Present'), ('Absent', 'Absent')])
#     updated_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True, related_name='attendance_updates')
