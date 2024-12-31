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

def filtered_reports(request):
    # Get filter parameters from the GET request
    from_date = request.GET.get('from_date')
    to_date = request.GET.get('to_date')
    department = request.GET.get('department')
    percentage = request.GET.get('percentage')
    print(f"Filters - From Date: {from_date}, To Date: {to_date}, Department: {department}, Percentage: {percentage}")

    # Start with attendance records
    queryset = Attendance.objects.values(
        'user_profile__user__username',
        'user_profile__user__first_name',
        'user_profile__user__last_name',
        'department__name',
    ).annotate(
        total_days=Count('date', distinct=True),
        present_days=Count(Case(When(status='Present', then=1))),
        half_present_days=Count(Case(When(status='Half Present', then=1))),
        absent_days=Count(Case(When(status='Absent', then=1))),
    ).annotate(
        percentage=Case(
            When(total_days__gt=0, then=((F('present_days') + F('half_present_days') * 0.5) * 100.0 / F('total_days'))),
            default=0,
            output_field=FloatField(),
        ),
        full_name=Concat(F('user_profile__user__first_name'), Value(' '), F('user_profile__user__last_name')),
    )

    # Apply filters based on request parameters
    if from_date:
        queryset = queryset.filter(date__gte=from_date)
    if to_date:
        queryset = queryset.filter(date__lte=to_date)
    if department and department != 'All Departments':
        queryset = queryset.filter(department__id=department)
    if percentage and percentage != 'All':
        if percentage == '90% and above':
            queryset = queryset.filter(percentage__gte=90)
        elif percentage == '80% - 89%':
            queryset = queryset.filter(percentage__gte=80, percentage__lt=90)
        elif percentage == '70% - 79%':
            queryset = queryset.filter(percentage__gte=70, percentage__lt=80)
        elif percentage == 'Below 70%':
            queryset = queryset.filter(percentage__lt=70)


    # Prepare the response data
    data = [
        {
            'username': record['user_profile__user__username'],
            'full_name': record['full_name'],
            'department_name': record['department__name'],
            'total_days': record['total_days'],
            'present_days': record['present_days'],
            'half_present_days': record['half_present_days'],
            'absent_days': record['absent_days'],
            'attendance_percentage': round(record['percentage'], 2),  # Round to 2 decimal places
        }
        for record in queryset
    ]
    print(data)
    # Return the data as a JSON response
    return JsonResponse(data, safe=False)



def get_records(request):
    if request.method == 'GET':
        department_id = request.GET.get('department_id')
        records = Attendance.objects.filter(department_id=department_id).values('username','fullname', 'date', 'status', 'check_in_time','check_out_time')
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
            profiles = Profile.objects.filter(department_id=department_id,role='regular')
            current_time = now()
            absent_users = []

            for profile in profiles:
                print(profile)

                # Check if attendance already exists for today
                existing_attendance = Attendance.objects.filter(
                    user_profile=profile,
                    date=current_time.date()
                ).first()  # Get the first attendance record for today if exists
                print(existing_attendance)

                if existing_attendance:
                    # Skip users who already have a record for today
                    print(f"Skipping {profile.user.username}, already marked as {existing_attendance.status}")
                    continue

                # If no attendance record exists, mark as absent
                department = Department.objects.get(id=department_id)
                Attendance.objects.create(
                    user_profile=profile,
                    department=department,
                    department_name=department.name,
                    username=profile.user.username,
                    fullname=profile.user.get_full_name(),
                    check_in_time=None,
                    check_out_time=None,
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





# def get_attendance(request):
#     # Get the department ID from the request
#     department_id = request.GET.get('department_id', None)
    
#     if department_id:
#         # Retrieve the department object
#         # department = Department.objects.get(id=department_id)
#         # Retrieve the department object by its ID
#         profiles_in_department = Profile.objects.filter(department_id=department_id,role='regular').exclude(face_embedding__isnull=True)
        
#         # Retrieve all user profiles in that department
#         # user_profiles = Profile.objects.filter(department=Department.objects.get(id=department_id))
#         print(profiles_in_department)
#         # Fetch attendance records for these users
#         attendance_data = []
        
#         for user_profile in profiles_in_department:
#             # Fetch attendance records for each user
#             attendance_records = Attendance.objects.filter(user_profile=user_profile)
            
#             for record in attendance_records:
#                 attendance_data.append({
#                     'student_name': user_profile.name,
#                     'date': record.date.strftime('%Y-%m-%d'),
#                     'status': record.status,  # Assume status is "Present", "Absent", etc.
#                 })
#     else:
#         return JsonResponse({"error": "Department not selected."}, status=400)

#     return JsonResponse({"attendance": attendance_data})



# class SaveAttendanceView(APIView):
#     def post(self, request):
#         serializer = AttendanceSerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response({'message': 'Attendance saved successfully'}, status=status.HTTP_201_CREATED)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

