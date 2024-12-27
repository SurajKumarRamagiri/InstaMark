# users/views.py
from django.db import IntegrityError
from django.shortcuts import render, redirect, get_object_or_404
from .models import Department, Profile
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse, Http404
from django.contrib import messages
from django.db.models import Q
from django.views.decorators.csrf import csrf_exempt
from .forms import DepartmentForm
from django.utils.timezone import now
from attendance.models import Attendance
from django.core.paginator import Paginator

def admin_reports(request):
    # Fetch attendance data, limiting to 30 records
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
    ).order_by('-date')[:30]  # Limit to a maximum of 30 records

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
    departments = Department.objects.all()

    # Context for rendering the template
    context = {
        'attendance_data': attendance_data,
        'departments': departments
    }
    return render(request, 'admin_reports.html', context)


@csrf_exempt
def user_list(request):
    if request.method != 'GET':
        return JsonResponse({'error': 'Invalid request method'}, status=400)

    search = request.GET.get('search', '')
    department_id = request.GET.get('department', '')
    role = request.GET.get('role', '')
    status = request.GET.get('status', '')

    users = User.objects.select_related('profile').all()
    print(users)

    # Apply filters
    if search:
        users = users.filter(
            Q(username__icontains=search) |
            Q(email__icontains=search) |
            Q(first_name__icontains=search) |
            Q(last_name__icontains=search)
        )
        print('1',users)
    if department_id:
        users = users.filter(profile__department_id=department_id)
        print('2',users)
    if role:
        users = users.filter(profile__role=role)
        print('3',users)

    if status:
        users = users.filter(is_active=(status.lower() == 'active'))
        print('4',users)

    user_data = [
        {
            'id': user.id,
            'username': user.username,
            'full_name': f"{user.first_name} {user.last_name}",
            'email': user.email,
            'department': user.profile.department.name if user.profile.department else '',
            'role': user.profile.role,
            'status': 'Active' if user.is_active else 'Inactive',
        }
        for user in users
    ]
    return JsonResponse({'users': user_data})




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
def manage_departments(request):
    departments = Department.objects.all()
    
    if request.method == 'POST':
        # Add a new department
        if 'add_department' in request.POST:
            form = DepartmentForm(request.POST)
            if form.is_valid():
                form.save()
                return redirect('admin_settings')
    
        # Edit an existing department
        elif 'edit_department' in request.POST:
            department_id = request.POST.get('department_id')
            department = get_object_or_404(Department, id=department_id)
            form = DepartmentForm(request.POST, instance=department)
            if form.is_valid():
                form.save()
                return redirect('admin_settings')
    
        # Delete a department
        elif 'delete_department' in request.POST:
            department_id = request.POST.get('department_id')
            department = get_object_or_404(Department, id=department_id)
            department.delete()
            return redirect('admin_settings')

    return redirect('admin_settings')



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
