# users/admin.py

from django.contrib import admin
from .models import Department
from .models import Profile

admin.site.register(Department)
admin.site.register(Profile)
