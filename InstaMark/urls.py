"""
URL configuration for InstaMark project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""

from django.contrib import admin
from django.urls import path,include
from . import views
from django.contrib.auth.views import LogoutView
from users import views as user_views
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('settings/',views.modify_and_get_settings,name='settings'),
    path('add-department/', views.add_department, name='add_department'),
    path('edit-department/', views.edit_department, name='edit_department'),
    path('delete-department/', views.delete_department, name='delete_department'),
    path('face_recognition/', include('face_recognition.urls')),
    path('attendance/', include('attendance.urls')),
    path('users/', include('users.urls')),
    path('delete-user/<int:user_id>/', views.delete_user, name='delete_user'),
    path('update-user/<int:user_id>/', views.update_user, name='update_user'),
    path('add_user/', user_views.add_user, name='add_user'),
    path('manager/dashboard/', views.manager_dashboard,name='manager_dashboard'),
    path('admin/reports/',views.admin_reports,name='admin_reports'),
    path('admin/settings/',views.admin_settings,name='admin_settings'),
    path('settings/',views.settings,name='settings'),
    path('admin/attendance/',views.admin_attendance ,name='admin_attendance'),
    path('attendance/',views.attendance ,name='attendance'),
    path('admin/users',views.admin_users,name='admin_users'),
    path('data_capture/',views.DataCapture, name='data_capture'),
    path('admin/dashboard/', views.admin_dashboard, name='admin_dashboard'),
    path('',views.home,name='home'),
    path('dashboard/', views.dashboard, name='dashboard'),
    path('signup/', views.signup, name='signup'),
    path('logout/',views.user_logout,name='logout'),
    path('login/',views.user_login, name='login'),
    path('user/dashboard/',views.user_dashboard,name='user_dashboard'),
    path("admin/", admin.site.urls),
]
