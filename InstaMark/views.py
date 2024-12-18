from django.contrib import messages
from django.shortcuts import render, redirect
from django.contrib.auth.forms import UserCreationForm,AuthenticationForm
from django.contrib.auth import login, logout, authenticate
from django.http import HttpResponse,JsonResponse
from django.contrib.auth.decorators import login_required,user_passes_test
from . import forms
from django.contrib.auth.models import User
from django.urls import reverse
from django.views.decorators.csrf import csrf_exempt
import json
from users.models import Profile
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
                user.first_name, user.last_name = data["name"].split(" ", 1)
            user.email = data.get("email", user.email)

            # Update custom fields (like department, role)
            if "department" in data:
                user.profile.department = data.get("department", user.profile.department)
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

# def add_user(request):
#     if request.method == 'POST':
#         username = request.POST.get('username')
#         first_name = request.POST.get('first_name')
#         last_name = request.POST.get('last_name')
#         email = request.POST.get('email')
#         password = request.POST.get('password')
#         department = request.POST.get('department')
#         role = request.POST.get('role')
#         is_active = request.POST.get('is_active') == 'true'

#         try:
#             user = User.objects.create_user(
#                 username=username,  # or generate a unique username
#                 email=email,
#                 password=password,
#                 first_name=first_name,
#                 last_name=last_name,
#                 is_active=is_active
#             )

#             profile = Profile(user=user, department=department, role=role)
#             profile.save()

#             if role == 'superuser':
#                 user.is_superuser = True
#             elif role == 'staff':
#                 user.is_staff = True
#             user.save()
#             messages.success(request, 'User added successfully!')

#         except Exception as e:
#             messages.error(request, f'Error adding user: {e}')

#         return redirect(reverse('admin_users'))
#     return render(request, 'add_user.html')


@login_required
def manager_dashboard(request):
    user=request.user.username
    return render(request, 'manager_dashboard.html')

def reports(request):
    return render(request,'reports.html')

def admin_settings(request):
    return render(request,'admin_settings.html')

def settings(request):
    return render(request,'settings.html')

def admin_attendance(request):
    return render(request,'admin_attendance.html')

def attendance(request):
    return render(request,'attendance.html')

def admin_users(request):
    users = User.objects.all()
    return render(request,'admin_users.html',{'users': users})

def DataCapture():
    return render(request,'DataCapture.html')

# Function to check if user is admin
def is_admin(user):
    return user.is_superuser

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

def user_login(request):
    if request.user.is_authenticated:
        user_role = request.user.profile.role
        if user_role == 'superuser':
            print(user_role)
            return redirect('admin_dashboard')
        elif user_role == 'staff':
            print(user_role)
            return redirect('manager_dashboard')
        elif user_role == 'regular':
            print(user_role)
            return redirect('user_dashboard')  
        else :
            print(user_role)
            return redirect('dashboard')      # Redirect to the home page if the user is logged in

    if request.method == 'POST':
        form = AuthenticationForm(data=request.POST)
        if form.is_valid():
            username = form.cleaned_data['username']
            password = form.cleaned_data['password']
            user = authenticate(request, username=username, password=password)
            if user is not None:
                login(request, user)
                user_role = request.user.profile.role
                if user_role == 'superuser':
                    print(user_role)
                    return redirect('admin_dashboard')
                elif user_role == 'staff':
                    print(user_role)
                    return redirect('manager_dashboard')
                elif user_role == 'regular':
                    print(user_role)
                    return redirect('user_dashboard')  
                else :
                    print(user_role)
                    return redirect('dashboard')
            else:
                form.add_error(None, 'Invalid username or password')
    else:
        form = AuthenticationForm()
    return render(request, 'login.html', {'form': form})

def user_logout(request):
    logout(request)
    return redirect('login')
