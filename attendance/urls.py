from django.urls import path
from . import views

urlpatterns = [
    path('get_records/', views.get_records, name='get_attendance_records'),
    path('mark_all_absent/', views.mark_all_absent, name='mark_all_absent'),
    path('get_attendance/', views.get_attendance, name='get_attendance'),
    path('save_attendance/', views.SaveAttendanceView.as_view(), name='save_attendance'),
]
