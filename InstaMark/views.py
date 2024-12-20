from django.contrib import messages
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.forms import UserCreationForm,AuthenticationForm
from django.contrib.auth import login, logout, authenticate
from django.http import HttpResponse,JsonResponse
from django.contrib.auth.decorators import login_required,user_passes_test
from . import forms
from django.contrib.auth.models import User
from django.urls import reverse
from django.views.decorators.csrf import csrf_exempt
import json
from users.models import Profile,Department

@csrf_exempt
def delete_user(request, user_id):
    if request.method == "DELETE":
        try:
            user = User.objects.get(id=user_id)
            user.delete()
            return JsonResponse({"success": True, "message": "User deleted successfully!"})
        except User.DoesNotExist:
            return JsonResponse({"success": False, "message": "User not found"}, status=404)
        except Exception as e:
            return JsonResponse({"success": False, "message": str(e)}, status=400)
    return JsonResponse({"success": False, "message": "Invalid request method"}, status=405)


@csrf_exempt
def update_user(request, user_id):
    if request.method == "POST":
        try:
            data = json.loads(request.body)
            user = User.objects.get(id=user_id)
            
            # Update fields (check for empty or None values)
            user.username = data.get("username", user.username)
            if "name" in data:
                name_parts = data["name"].split(" ", 1)
                user.first_name = name_parts[0]
                user.last_name = name_parts[1] if len(name_parts) > 1 else ""

            user.email = data.get("email", user.email)

            # Update custom fields (like department, role)
            if "department" in data:
                # user.profile.department = data.get("department", user.profile.department)
                department_name = data.get("department")
                department = get_object_or_404(Department, name=department_name)  # Get the department instance
                user.profile.department = department
            if "role" in data:
                user.profile.role = data.get("role", user.profile.role)
            if "status" in data:
                user.is_active = data.get("status", "").lower() == "active"

            # Save changes
            user.save()
            user.profile.save()

            return JsonResponse({"success": True, "message": "User updated successfully!"})

        except User.DoesNotExist:
            return JsonResponse({"success": False, "message": "User not found!"}, status=404)

        except Exception as e:
            return JsonResponse({"success": False, "message": str(e)}, status=400)
            
    return JsonResponse({"success": False, "message": "Invalid request method"}, status=405)

@login_required
def manager_dashboard(request):
    user=request.user.username
    return render(request, 'manager_dashboard.html')

def reports(request):
    return render(request,'reports.html')

def admin_settings(request):
    departments=Department.objects.all()
    return render(request,'admin_settings.html',{'departments': departments})

def settings(request):
    return render(request,'settings.html')

def admin_attendance(request):
    departments=Department.objects.all()
    return render(request,'admin_attendance.html',{'departments': departments})

def attendance(request):
    return render(request,'attendance.html')

def admin_users(request):
    users = User.objects.all()
    departments=Department.objects.all()
    context = {
        'users': users,
        'departments': departments
    }
    return render(request,'admin_users.html',context)

def DataCapture():
    return render(request,'DataCapture.html')

# Function to check if user is admin
def is_admin(user):
    return user.profile.role=='superuser'

# Dashboard view
@user_passes_test(is_admin)
def admin_dashboard(request):
    user=request.user.username
    return render(request, 'admin_dashboard.html',{'active_page': 'dashboard'})

def home(request):
    return render(request,'home.html')

def signup(request):
    if request.method == 'POST':
        form = UserCreationForm(request.POST)
        if form.is_valid():
            user=form.save()
            messages.success(request, 'Account created successfully!')
            login(request,user)
            return user_login(request)
    else:
        form = UserCreationForm()
    return render(request, 'signup.html', {'form': form})


@login_required
def user_dashboard(request):
    user=request.user.username
    return render(request,'user_dashboard.html')

def dashboard(request):
    return render(request,'dashboard_base.html')

from django.shortcuts import redirect
from django.contrib.auth import authenticate, login
from django.contrib.auth.forms import AuthenticationForm

def user_login(request):
    # Check if user is already authenticated
    if request.user.is_authenticated:
        # Get the user's role from the profile
        try:
            user_role = request.user.profile.role
        except Profile.DoesNotExist:
            # If the profile does not exist, redirect to the home page
            print("profile does not exist")
            return redirect('dashboard')

        # Redirect based on the user's role
        if user_role == 'superuser':
            # print("superuser")
            return redirect('admin_dashboard')
        elif user_role == 'staff':
            # print("staff")
            return redirect('manager_dashboard')
        elif user_role == 'regular':
            # print("regular")
            return redirect('user_dashboard')
        else:
            # print("unknown role")
            return redirect('dashboard')  # Default redirect if role is unknown

    # Handle login form submission
    if request.method == 'POST':
        form = AuthenticationForm(data=request.POST)
        if form.is_valid():
            username = form.cleaned_data['username']
            password = form.cleaned_data['password']
            user = authenticate(request, username=username, password=password)
            if user is not None:
                login(request, user)  # Log the user in
                # Get the role of the user after login
                try:
                    user_role = user.profile.role
                except Profile.DoesNotExist:
                    # If profile does not exist, redirect to the default dashboard
                    return redirect('dashboard')

                # Redirect based on the user's role
                if user_role == 'superuser':
                    return redirect('admin_dashboard')
                elif user_role == 'staff':
                    return redirect('manager_dashboard')
                elif user_role == 'regular':
                    return redirect('user_dashboard')
                else:
                    return redirect('dashboard')  # Default if role is unknown

            else:
                # If authentication failed, add an error to the form
                form.add_error(None, 'Invalid username or password')
    else:
        # If the request method is not POST, simply show the login page
        form = AuthenticationForm()
        return render(request, 'login.html', {'form': form})


def user_logout(request):
    logout(request)
    return redirect('login')
