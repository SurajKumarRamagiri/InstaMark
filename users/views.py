# users/views.py

from django.shortcuts import render, redirect
from .models import Department, Profile
from django.contrib.auth.models import User




def manage_departments(request):
    if request.method == 'POST':
        # Handling new department addition
        department_name = request.POST.get('department_name')
        if department_name:
            Department.objects.create(name=department_name)
        return redirect('manage_departments')
    
    departments = Department.objects.all()
    return render(request, 'manage_departments.html', {'departments': departments})


def add_user(request):
    if request.method == 'POST':
        username = request.POST['username']
        first_name = request.POST['first_name']
        last_name = request.POST['last_name']
        email = request.POST['email']
        password = request.POST['password']
        department_id = request.POST['department']
        role = request.POST['role']
        is_active = request.POST['is_active'] == 'true'

        # Create new user
        user = User.objects.create_user(
            username=username,
            first_name=first_name,
            last_name=last_name,
            email=email,
            password=password
        )
        user.is_active = is_active
        user.save()

        # Assign department and role via Profile
        department = Department.objects.get(id=department_id)
        Profile.objects.create(user=user, department=department, role=role)

        return redirect('user_list')  # Redirect to a page showing the user list
    
    departments = Department.objects.all()  # Get all departments
    return render(request, 'add_user.html', {'departments': departments})
