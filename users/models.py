from django.db import models
from django.contrib.auth.models import User

from django.db.models.signals import post_save
from django.dispatch import receiver

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    department = models.CharField(max_length=50, choices=[('hr', 'HR'), ('engineering', 'Engineering'), ('marketing', 'Marketing'), ('sales', 'Sales')])
    role = models.CharField(max_length=50, choices=[('superuser', 'Superuser'), ('staff', 'Staff'), ('regular', 'Regular User')])

    def __str__(self):
        return self.user.username

# Signal to create a profile when a user is created
@receiver(post_save, sender=User)
def create_user_profile(sender, instance, created, **kwargs):
    if created:
        Profile.objects.create(user=instance)

# Signal to save profile when a user is saved
@receiver(post_save, sender=User)
def save_user_profile(sender, instance, **kwargs):
    instance.profile.save()

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
