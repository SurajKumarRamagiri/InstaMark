# users/urls.py

from django.urls import path
from . import views

urlpatterns = [
    path('api/departments/', views.get_departments, name='get_departments'),
    path('delete-department/<int:department_id>/', views.delete_department, name='delete_department'),
    path("edit-department/<int:department_id>/", views.edit_department, name="edit_department"),
    path('add-department/', views.add_department, name='add_department'),
    path('add-user/', views.add_user, name='add_user'),
    # Add URLs for edit and delete if required
]
