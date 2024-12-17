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
from django.urls import path
from . import views
from django.contrib.auth.views import LogoutView

urlpatterns = [
    path('delete-user/<int:user_id>/', views.delete_user, name='delete_user'),
    path('update-user/<int:user_id>/', views.update_user, name='update_user'),
    path('add_user/', views.add_user, name='add_user'),
    path('manager/dashboard/', views.manager_dashboard,name='manager_dashboard'),
    path('reports/',views.reports,name='reports'),
    path('settings/',views.settings,name='settings'),
    path('attendance/',views.attendance ,name='attendance'),
    path('admin/users',views.admin_users,name='admin_users'),
    path('data_capture/',views.DataCapture, name='data_capture'),
    path('admin/dashboard/', views.admin_dashboard, name='admin_dashboard'),
    path('',views.home,name='home'),
    path('signup/', views.signup, name='signup'),
    path('logout/',views.user_logout,name='logout'),
    path('login/',views.user_login, name='login'),
    path('user/dashboard/',views.user_dashboard,name='user_dashboard'),
    path("admin/", admin.site.urls),
]
