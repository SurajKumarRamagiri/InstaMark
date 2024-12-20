# users/admin.py

from django.contrib import admin
from .models import Department,Profile

admin.site.register(Profile)
# admin.site.register(Department)

@admin.register(Department)
class DepartmentAdmin(admin.ModelAdmin):
    list_display = ('name',)
    search_fields = ('name',)
