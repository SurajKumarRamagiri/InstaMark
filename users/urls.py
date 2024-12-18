# users/urls.py

from django.urls import path
from . import views

urlpatterns = [
    path('manage-departments/', views.manage_departments, name='manage_departments'),
    path('add-user/', views.add_user, name='add_user'),
    # Add URLs for edit and delete if required
]
