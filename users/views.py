# users/views.py
from django.db import IntegrityError
from django.shortcuts import render, redirect, get_object_or_404
from .models import Department, Profile
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse, Http404
from django.contrib import messages



def get_departments(request):
    departments = Department.objects.values('id', 'name')
    return JsonResponse({'departments': list(departments)})


def delete_department(request, department_id):
    # Get the department by ID, or return 404 if not found
    department = get_object_or_404(Department, id=department_id)
    # Delete the department
    department.delete()
    # Redirect to the settings page after deletion
    return redirect('admin_settings')

def edit_department(request, department_id):
    if request.method == "POST":
        department = get_object_or_404(Department, id=department_id)
        new_name = request.POST.get("name")
        if new_name:
            department.name = new_name
            department.save()
            messages.success(request, "Department updated successfully.")
        else:
            messages.error(request, "Department name cannot be empty.")
    return redirect("manage_departments")

@login_required
def add_department(request):
    if request.method == 'POST':
        # Handling new department addition
        department_name = request.POST.get('name')
        print(department_name)
        if department_name:
            Department.objects.create(name=department_name)
        return redirect('admin_settings')
    
    departments = Department.objects.all()
    return render(request, 'admin_settings.html', {'departments': departments})


def add_user(request):
    if request.method == 'POST':
        username = request.POST['username']
        first_name = request.POST['first_name']
        last_name = request.POST['last_name']
        email = request.POST['email']
        password = request.POST['password']
        department_id = request.POST["department"]
        role = request.POST['role']
        is_active = request.POST['is_active'] == 'true'
        #print(role,department_id)
        try:
            # Create new user
            user = User.objects.create_user(
                username=username,
                first_name=first_name,
                last_name=last_name,
                email=email,
                password=password,
                is_active = is_active
            )
            # Check if a profile already exists for this user
            profile, created = Profile.objects.get_or_create(
                user=user,  # This will use the user ID to find the profile
                defaults={'department_id': department_id, 'role': role}
            )
            # If the profile is not created (i.e., it already exists), update it
            if not created:
                profile.department_id = department_id
                profile.role = role
                profile.save()
            return redirect('admin_users')  # Redirect to a page showing the user list

        except IntegrityError as e:
            return render(request, 'error.html', {'message': str(e)})
        except Department.DoesNotExist:
            return render(request, 'error.html', {'message': "Department does not exist."})
    return redirect('admin_users')
