from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import Attendance
from .serializers import AttendanceSerializer
from django.shortcuts import render
from users.models import Profile, Department
from django.shortcuts import render
from PIL import Image
from io import BytesIO
import dlib,json,base64,cv2
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse, Http404
from users.models import Department, Profile
from django.utils import timezone
from datetime import timedelta
import requests
from django.db.models import Count, Q, F, Case, When, FloatField, Value
from django.db.models.functions import Concat
from datetime import datetime, timedelta
from django.utils.timezone import now

def reports(request):
    # Get filter parameters from the GET request
    from_date = request.GET.get('from_date')
    to_date = request.GET.get('to_date')
    department = request.GET.get('department')
    percentage = request.GET.get('percentage')
    print(f"Filters - From Date: {from_date}, To Date: {to_date}, Department: {department}, Percentage: {percentage}")


    # Start with all attendance records
    # Annotate the attendance queryset
    queryset = (
        Attendance.objects.values('user_profile__id', 'user_profile__user__username')
        .annotate(
            # Calculate total days with 1 attendance records
            total_days=Count('date', filter=Count('date') == 1),
            # Calculate present days
            present_days=Count(Case(When(status='Present', then=1))),
            # Calculate absent days
            absent_days=Count(Case(When(status='Absent', then=1))),
            # calculate half Present days
            half_present_days=Count(Case(When(status='Half Present', then=0.5))),
            # Calculate attendance percentage
            percentage=Case(
                When(total_days__gt=0, then=(F('present_days')+F('half_present_days')) * 100.0 / F('total_days')),
                default=0, output_field=FloatField(),)
        )
    )

    # Apply filters based on the request parameters
    if from_date:
        queryset = queryset.filter(date__gte=from_date)

    if to_date:
        queryset = queryset.filter(date__lte=to_date)

    if percentage and percentage != 'All':
        if percentage == '90% and above':
            queryset = queryset.filter(percentage__gte=90)
        elif percentage == '80% - 89%':
            queryset = queryset.filter(percentage__gte=80, percentage__lt=90)
        elif percentage == '70% - 79%':
            queryset = queryset.filter(percentage__gte=70, percentage__lt=80)
        elif percentage == 'Below 70%':
            queryset = queryset.filter(percentage__lt=70)

    if department and department != 'All Departments':
        queryset = queryset.filter(department__id=department)  # Ensure field name is correct

    # Debugging the queryset after filters
    print(f"Filtered QuerySet Count: {queryset.count()}")

    # Annotate with the full name by concatenating first and last names
    queryset = queryset.annotate(
        full_name=Concat(F('user_profile__user__first_name'), Value(' '), F('user_profile__user__last_name'))
    ).values(
        'user_profile__user__username',
        'full_name',
        'department__name',
        'status',
        'percentage',
        'date',
        'user_profile__user__id',
    )

    # Prepare attendance data
    user_attendance = {}
    for item in queryset:
        user_id = item['user_profile__user__id']
        if user_id not in user_attendance:
            user_attendance[user_id] = {
                'username': item['user_profile__user__username'],
                'full_name': item['full_name'],
                'department_name': item['department__name'],
                'total_days': 0,
                'present_days': 0,
                'half_present_days': 0,
                'absent_days': 0,
                'attendance_percentage': item['percentage'],  # Initialize with raw percentage
            }
        
        # Increment attendance counts
        user_attendance[user_id]['total_days'] += 1
        if item['status'] == 'Present':
            user_attendance[user_id]['present_days'] += 1
        elif item['status'] == 'Half Present':
            user_attendance[user_id]['half_present_days'] += 1
        else:
            user_attendance[user_id]['absent_days'] += 1

    # Prepare the final list for response
    data = []
    for user in user_attendance.values():
        user['attendance_percentage'] = (
            ((user['present_days']+ user['half_present_days']) / user['total_days']) * 100
            if user['total_days'] > 0
            else 0
        )
        data.append(user)

    # Return the data as a JSON response
    return JsonResponse(data, safe=False)


def get_records(request):
    if request.method == 'GET':
        department_id = request.GET.get('department_id')
        records = Attendance.objects.filter(department_id=department_id).values('fullname', 'date', 'status', 'check_in_time','check_out_time')
        return JsonResponse(list(records), safe=False)

    return JsonResponse({'error': 'Invalid request method'}, status=400)



@csrf_exempt
def mark_all_absent(request):
    if request.method == 'POST':
        department_id = request.GET.get('department_id')

        if not department_id:
            return JsonResponse({'message': 'Department ID not provided'}, status=400)

        try:
            # Get all profiles in the specified department
            profiles = Profile.objects.filter(department_id=department_id)
            current_time = now()
            absent_users = []

            for profile in profiles:
                print(profile)
                # Check if attendance already exists for today
                last_attendance = Attendance.objects.filter(
                    user_profile=profile,
                    date=current_time.date()
                ).order_by('-check_in_time').first()  # Get the most recent attendance record for today
                print(last_attendance)

                # Check if there's an attendance record
                if last_attendance:
                    print('Attendance record exists')
                    # Combine date and time to form the attendance datetime
                    attendance_time = datetime.combine(last_attendance.date, last_attendance.check_in_time)
                    # Calculate time difference
                    time_difference = current_time - attendance_time
                    print(time_difference)

                    # Skip if the user has a recent attendance marked within 40 minutes
                    if time_difference <= timedelta(minutes=40):
                        continue
                    if time_difference > timedelta(minutes=40) :
                        department = Department.objects.get(id=department_id)
                        Attendance.objects.create(
                            user_profile=profile,
                            department=department,
                            department_name=department.name,
                            username=profile.user.username,
                            fullname=profile.user.get_full_name(),
                            check_in_time=None,
                            status='Absent',
                        )
                        absent_users.append(profile.user.username)

                # If no attendance record or not within 40 minutes, mark as absent
                if not last_attendance :
                    print('hi')
                    department = Department.objects.get(id=department_id)
                    Attendance.objects.create(
                        user_profile=profile,
                        department=department,
                        department_name=department.name,
                        username=profile.user.username,
                        fullname=profile.user.get_full_name(),
                        check_in_time=None,
                        status='Absent',
                    )
                    absent_users.append(profile.user.username)

            return JsonResponse({
                'message': 'All users marked as absent successfully!',
                'absent_users': absent_users,
            }, status=200)

        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)

    return JsonResponse({'message': 'Invalid request method'}, status=400)





def get_attendance(request):
    # Get the department ID from the request
    department_id = request.GET.get('department_id', None)
    
    if department_id:
        # Retrieve the department object
        # department = Department.objects.get(id=department_id)
        # Retrieve the department object by its ID
        profiles_in_department = Profile.objects.filter(department_id=department_id).exclude(face_embedding__isnull=True)
        
        # Retrieve all user profiles in that department
        # user_profiles = Profile.objects.filter(department=Department.objects.get(id=department_id))
        print(profiles_in_department)
        # Fetch attendance records for these users
        attendance_data = []
        
        for user_profile in profiles_in_department:
            # Fetch attendance records for each user
            attendance_records = Attendance.objects.filter(user_profile=user_profile)
            
            for record in attendance_records:
                attendance_data.append({
                    'student_name': user_profile.name,
                    'date': record.date.strftime('%Y-%m-%d'),
                    'status': record.status,  # Assume status is "Present", "Absent", etc.
                })
    else:
        return JsonResponse({"error": "Department not selected."}, status=400)

    return JsonResponse({"attendance": attendance_data})



class SaveAttendanceView(APIView):
    def post(self, request):
        serializer = AttendanceSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({'message': 'Attendance saved successfully'}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

