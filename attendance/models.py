from django.db import models
from django.contrib.auth.models import User 
from users.models import Department, Profile

class Attendance(models.Model):
    user_profile = models.ForeignKey(Profile, on_delete=models.CASCADE, null=True,related_name='attendances')  # This links to the User model
    department = models.ForeignKey(Department, on_delete=models.CASCADE,default=0)  # Assuming you have a Department model
    date = models.DateField(auto_now_add=True)  # For storing the date of attendance
    status = models.CharField(max_length=20, choices=[('Present', 'Present'),('Half Present','Half Present'), ('Absent', 'Absent')])
    department_name = models.CharField(max_length=100, blank=True)  # For storing department name
    username = models.CharField(max_length=150, blank=True)  # For storing username
    fullname = models.CharField(max_length=150, blank=True)  # For storing full name
    check_in_time = models.TimeField(null=True,blank=True)  # For storing the time of checkin
    check_out_time = models.TimeField(null=True,blank=True)  # For storing the time of checkout
    location = models.CharField(max_length=255, null=True, blank=True)  # New field for location
    # add late boolean value
    late = models.BooleanField(default=False)


    def __str__(self):
        return f"{self.department_name} - {self.username} - {self.fullname} - {self.status} - {self.check_in_time} - {self.check_out_time}- {self.date} - {self.late} - {self.location}"
