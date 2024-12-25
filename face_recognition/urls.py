from django.urls import path
from . import views

urlpatterns = [
    path('recognise_face/', views.recognise_face , name='recognise_face'),
    path('register_face/', views.register_face , name='register_face'),
]
