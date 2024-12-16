from django.contrib import admin
from django.contrib.auth.models import Group

# Create custom groups if necessary
admin.site.register(Group)
