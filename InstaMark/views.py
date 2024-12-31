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
import json,csv
from users.models import Profile,Department
from attendance.models import Attendance
from django.db.models import Count, Q, F, Case, When, FloatField, Value
from django.db.models.functions import Concat
from django.shortcuts import render
from django.utils.timezone import now,localdate,timedelta
from attendance.models import Attendance
from users.forms import DepartmentForm
from django.utils.decorators import method_decorator
from django.http import QueryDict
from django.shortcuts import render, get_object_or_404
from django.views import View
from django.http import HttpResponseBadRequest
from settings.views import get_system_settings
from settings.models import SystemSettings
from django.http import JsonResponse
from django.shortcuts import render, redirect
from django.core.mail import send_mail
from django.conf import settings

def send_notification_email(subject, message, recipient_email):
    try:
        # Sending the email
        send_mail(
            subject,
            message,
            settings.DEFAULT_FROM_EMAIL,
            settings.EMAIL_HOST_USER  # Sender's email
            [recipient_email],  # List of recipients
            fail_silently=False,  # Don't fail silently, show errors
        )
        return "Email sent successfully"
    except Exception as e:
        # Log the exception and return a failure message
        print(f"Error while sending email: {str(e)}")
        return f"Failed to send email: {str(e)}"

@csrf_exempt
def modify_and_get_settings(request):
    # Retrieve the settings object, assuming there is only one row in the settings table
    settings = get_system_settings()

    if not settings:
        settings = SystemSettings.objects.create(
            attendance_time_limit=30,
            face_recognition_threshold=0.6
        )

    if request.method == 'POST':
        # Get the form data from the POST request
        attendance_time_limit = request.POST.get('attendance_time_limit')
        face_recognition_threshold = request.POST.get('face_recognition_threshold')

        # Update the settings object with the new values
        if attendance_time_limit:
            settings.attendance_time_limit = int(attendance_time_limit)  # Convert to int
        if face_recognition_threshold:
            settings.face_recognition_threshold = float(face_recognition_threshold)  # Convert to float

        # Save the updated settings to the database
        settings.save()

        # Redirect to the settings page after saving
        return redirect('admin_settings')

    elif request.method == 'GET':
        # If it's a GET request, return the current settings as JSON
        return JsonResponse({
            'attendance_time_limit': settings.attendance_time_limit,
            'face_recognition_threshold': settings.face_recognition_threshold,
        })

    # For rendering the settings page when requested
    context = {
        'settings': settings,
    }
    return render(request, 'admin_settings.html', context)


# Fetch all departments and render the page
def admin_settings(request):
    if request.method == "GET":
        # Get all departments
        departments = Department.objects.all().values('id', 'name')
        return JsonResponse({"departments": list(departments)})

    return render(request, 'admin_settings.html')

# Add a new department
@csrf_exempt
def add_department(request):
    if request.method == 'POST':
        name = request.POST.get("name")
        if name:
            department = Department.objects.create(name=name)
            return JsonResponse({"success": True, "id": department.id, "name": department.name})
        return JsonResponse({"success": False, "error": "Name is required."})

# Edit department
@csrf_exempt
def edit_department(request):
    if request.method == 'PUT':
        put_data = QueryDict(request.body)
        department_id = put_data.get("id")
        department_name = put_data.get("name")
        department = get_object_or_404(Department, id=department_id)
        department.name = department_name
        department.save()
        return JsonResponse({"success": True})

# Delete department

@csrf_exempt  # disables CSRF protection
def delete_department(request):
    if request.method == 'POST':
        action = request.POST.get('action')
        if action == 'delete':  # Check if the action is to delete
            department_id = request.POST.get('id')  # Get department ID
            department = get_object_or_404(Department, id=department_id)
            department.delete()  # Delete the department
            return JsonResponse({"success": True})
        else:
            return JsonResponse({"success": False, "error": "Invalid action."})
    
    return JsonResponse({"success": False, "error": "Invalid method."})



def admin_reports(request):
    # Query all attendance records
    attendance_queryset = Attendance.objects.annotate(
        full_name=Concat(F('user_profile__user__first_name'), Value(' '), F('user_profile__user__last_name'))
    ).values(
        'user_profile__user__username',
        'full_name',
        'department__name',
        'status',
        'user_profile__user__id',
    ).annotate(
        total_days=Count('date', distinct=True),
        present_days=Count(Case(When(status='Present', then=1))),
        half_present_days=Count(Case(When(status='Half Present', then=1))),
        absent_days=Count(Case(When(status='Absent', then=1))),
    ).annotate(
        attendance_percentage=Case(
            When(total_days__gt=0, then=((F('present_days') + F('half_present_days') * 0.5) * 100.0 / F('total_days'))),
            default=0,
            output_field=FloatField(),
        ),
    )
    
    # Prepare a dictionary to aggregate attendance data for each user
    user_attendance = {}

    for record in attendance_queryset:
        user_id = record['user_profile__user__id']
        if user_id not in user_attendance:
            user_attendance[user_id] = {
                'username': record['user_profile__user__username'],
                'name': record['full_name'],
                'department': record['department__name'],
                'total_days': record['total_days'],
                'present_days': record['present_days'],
                'half_present_days': record['half_present_days'],
                'absent_days': record['absent_days'],
                'attendance_percentage': round(record['attendance_percentage'], 2),
            }

    # Convert to a list for template rendering
    attendance_data = list(user_attendance.values())
    departments=Department.objects.all()

    # Context for rendering the template
    context = {
        'attendance_data': attendance_data,
        'departments': departments
    }
    return render(request, 'admin_reports.html', context)

# def admin_reports(request):
#     # Get filter parameters from the GET request

#     # Start with attendance records
#     queryset = Attendance.objects.values(
#         'user_profile__user__username',
#         'user_profile__user__first_name',
#         'user_profile__user__last_name',
#         'department__name',
#     ).annotate(
#         total_days=Count('date', distinct=True),
#         present_days=Count(Case(When(status='Present', then=1))),
#         half_present_days=Count(Case(When(status='Half Present', then=1))),
#         absent_days=Count(Case(When(status='Absent', then=1))),
#     ).annotate(
#         percentage=Case(
#             When(total_days__gt=0, then=((F('present_days') + F('half_present_days') * 0.5) * 100.0 / F('total_days'))),
#             default=0,
#             output_field=FloatField(),
#         ),
#         full_name=Concat(F('user_profile__user__first_name'), Value(' '), F('user_profile__user__last_name')),
#     )


#     # Prepare the response data
#     data = [
#         {
#             'username': record['user_profile__user__username'],
#             'full_name': record['full_name'],
#             'department_name': record['department__name'],
#             'total_days': record['total_days'],
#             'present_days': record['present_days'],
#             'half_present_days': record['half_present_days'],
#             'absent_days': record['absent_days'],
#             'attendance_percentage': round(record['percentage'], 2),  # Round to 2 decimal places
#         }
#         for record in queryset
#     ]
#     print(data)
#     # Return the data as a JSON response
#     return JsonResponse(data, safe=False)
#     # Context for rendering the template
#   context = {
#         'attendance_data': attendance_data,
#         'departments': departments
#   }
#    return render(request, 'admin_reports.html',)


def user_dashboard(request):
    user = request.user  # get logged-in user
    attendance_data = Attendance.objects.filter(username=user)
    total_days = attendance_data.count()
    
    # Count attendance types
    present_count = attendance_data.filter(status='Present').count()
    half_present_count = attendance_data.filter(status='Half Present').count()
    absent_count = attendance_data.filter(status='Absent').count()
    late_count = attendance_data.filter(status='Late').count()
    print(total_days,present_count,half_present_count,absent_count,late_count)

    # Prepare attendance summary
    attendance_summary = {
        'total_days': total_days,
        'present_count': present_count,
        'half_present_count': half_present_count,
        'absent_count': absent_count,
        'late_count': late_count,
        'overall_percentage': ((present_count + (half_present_count * 0.5) + (late_count * 0.75)) / total_days) * 100 if total_days > 0 else 0,
    }

    context = {
        'user': user,
        'attendance_data': attendance_data,
        'attendance_summary': attendance_summary
    }
    return render(request, 'user_dashboard.html', context)

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
    departments = Department.objects.all()
    # Pass the data to the template
    return render(request, 'manager_dashboard.html', { 'departments': departments,})

@csrf_exempt
def admin_settings(request):
    departments=Department.objects.all()
    if request.method == "POST":
        # Create a list of department dictionaries with id and name
        data = [{"id": dept.id, "name": dept.name} for dept in departments]
        return JsonResponse({'departments': data})
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
    user_count = User.objects.count()
    department_count = Department.objects.count()
    manager_count = User.objects.filter(profile__role='staff').count()  # Define manager count
    
    return render(request, 'admin_dashboard.html', {
        'active_page': 'dashboard',
        'user_count': user_count,
        'department_count': department_count,
        'manager_count': manager_count,
    })
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
                # Invalid credentials error
                messages.error(request, "Invalid username or password.")
        
                # If authentication failed, add an error to the form
        else:
            messages.error(request, 'please correct the errors below')

    else:
        # If the request method is not POST, simply show the login page
        form = AuthenticationForm()
    return render(request, 'login.html', {'form': form})


def user_logout(request):
    logout(request)
    return redirect('login')
