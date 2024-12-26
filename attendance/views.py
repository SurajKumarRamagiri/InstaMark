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
from attendance.models import Attendance
from django.utils import timezone
from datetime import timedelta
import requests

def get_records(request):
    if request.method == 'GET':
        department_id = request.GET.get('department_id')
        records = Attendance.objects.filter(department_id=department_id).values('fullname', 'date', 'status', 'time')
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

            for profile in profiles:
                # Check if attendance already exists for today
                if not Attendance.objects.filter(
                    user_profile=profile,
                    date=timezone.now().date()
                ).exists():
                    # Create an attendance record with status 'Absent'
                    Attendance.objects.update_or_create(
                        user_profile=profile,
                        department=Department.objects.get(id=department_id),
                        department_name=Department.objects.get(id=department_id).name,
                        username=profile.user.username,
                        fullname=profile.user.get_full_name(),
                        status='Absent',
                    )

            return JsonResponse({'message': 'All users marked as absent successfully!'}, status=200)

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

