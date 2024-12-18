from django.contrib import admin
from django.contrib.auth.models import User

# Create custom groups if necessary
admin.site.register(User)
