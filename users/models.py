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

    def get_face_embedding(self):
        return np.array(json.loads(self.face_embedding))  # Convert from JSON to numpy array