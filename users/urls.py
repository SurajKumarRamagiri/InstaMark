# users/urls.py

from django.urls import path
from . import views

urlpatterns = [
    path('user_list/', views.user_list, name='user_list'),
    path('add-user/', views.add_user, name='add_user'),
    # Add URLs for edit and delete if required
]
