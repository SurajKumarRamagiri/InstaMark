from django.shortcuts import render
import numpy as np
from PIL import Image
from io import BytesIO
import dlib,json,base64,cv2
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse, Http404
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from users.models import Department, Profile
from attendance.models import Attendance
from django.utils import timezone
from datetime import datetime, timedelta
import requests
from django.db.models import Q
from face_recognition.config import ATTENDANCE_TIME_WINDOW, RECOGNITION_THRESHOLD


# Create your views here.
# Load dlib's face detection and embedding models
detector = dlib.get_frontal_face_detector()
face_rec_model = dlib.face_recognition_model_v1('utilities/dlib_face_recognition_resnet_model_v1.dat')
shape_predictor = dlib.shape_predictor('utilities/shape_predictor_68_face_landmarks.dat')


# Constants
ATTENDANCE_TIME_WINDOW = timedelta(minutes=40)  # 40 minutes threshold for check-out
HALF_PRESENT_TIME_THRESHOLD = ATTENDANCE_TIME_WINDOW/2  # 20 minutes threshold for half-present

@csrf_exempt
def recognise_face(request):
    if request.method != 'POST':
        return JsonResponse({'error': 'Invalid request method'}, status=400)

    try:
        # Parse request data
        data = json.loads(request.body)
        image_data = data.get('image')
        department_id = data.get('department_id')

        if not image_data:
            return JsonResponse({'message': 'Image data not provided.'}, status=400)
        if not department_id:
            return JsonResponse({'message': 'Department ID not provided.'}, status=400)

        # Decode the Base64 image data
        try:
            format, imgstr = image_data.split(';base64,')
            image_bytes = base64.b64decode(imgstr)
            image = Image.open(BytesIO(image_bytes)).convert('RGB')
        except Exception:
            return JsonResponse({'message': 'Invalid image format.'}, status=400)

        # Convert image to numpy array
        image_np = np.array(image)

        # Detect faces using dlib
        faces = detector(image_np, 1)
        if len(faces) != 1:
            return JsonResponse({'message': 'No face or multiple faces detected.'}, status=400)

        # Extract face landmarks and embeddings
        face = faces[0]
        shape = shape_predictor(image_np, face)
        face_embedding = np.array(face_rec_model.compute_face_descriptor(image_np, shape))

        # Get profiles in the department
        profiles = Profile.objects.filter(department_id=department_id,role='regular').exclude(face_embedding__isnull=True)
        if not profiles.exists():
            return JsonResponse({'message': 'No registered profiles in the department.'}, status=404)

        # Recognize face by comparing embeddings
        matched_user, min_distance = None, RECOGNITION_THRESHOLD
        for profile in profiles:
            try:
                known_embedding = np.array(profile.face_embedding, dtype=np.float64)
                distance = np.linalg.norm(face_embedding - known_embedding)
                if distance < min_distance:
                    min_distance = distance
                    matched_user = profile
            except Exception:
                continue

        if not matched_user:
            return JsonResponse({'message': 'Face not recognized.'}, status=404)

        matched_username = matched_user.user.username
        matched_full_name = matched_user.user.get_full_name()
        print(matched_username)

        today = timezone.now().date()

        # Check if attendance record exists for today
        last_attendance = Attendance.objects.filter(
            user_profile=matched_user,
            date=today
        ).first()
        print(last_attendance)
        if last_attendance:
            # Update the existing record based on time of recognition
            time_difference = (timezone.now() - datetime.combine(last_attendance.date, last_attendance.check_in_time))
            print(time_difference)
            print(HALF_PRESENT_TIME_THRESHOLD)
            if time_difference < HALF_PRESENT_TIME_THRESHOLD:
                last_attendance.status = 'Absent'
                return JsonResponse({'message': f'Attendance already marked for \n{matched_username} ({matched_full_name}). \nplease try again after some time'}, status=200)
            elif HALF_PRESENT_TIME_THRESHOLD <= time_difference < ATTENDANCE_TIME_WINDOW:
                last_attendance.status = 'Half Present'
                last_attendance.check_out_time = timezone.now()
            elif time_difference >= ATTENDANCE_TIME_WINDOW:
                last_attendance.status = 'Present'
                last_attendance.check_out_time = timezone.now()
            
            print(last_attendance)            
            last_attendance.save()
            return JsonResponse({'message': f'Attendance updated to {last_attendance.status} for \n{matched_username} ({matched_full_name}).'}, status=200)

        # If no attendance record exists, create a new one
        department = Department.objects.get(id=department_id)
        Attendance.objects.create(
            user_profile=matched_user,
            department=department,
            department_name=department.name,
            username=matched_username,
            fullname=matched_full_name,
            status='Absent',  # Initially mark as Absent
            check_in_time=timezone.now(),  # Mark check-in time
            check_out_time=None,
        )
        return JsonResponse({'message': f'Attendance recorded for {matched_full_name} ({matched_username}).'}, status=200)

    except Exception as e:
        return JsonResponse({'error': f"An error occurred: {str(e)}"}, status=500)




# @csrf_exempt
# def recognise_face(request):
#     if request.method != 'POST':
#         return JsonResponse({'error': 'Invalid request method'}, status=400)

#     try:
#         # Parse request data
#         data = json.loads(request.body)
#         image_data = data.get('image')
#         department_id = data.get('department_id')

#         if not image_data:
#             return JsonResponse({'message': 'Image data not provided.'}, status=400)
#         if not department_id:
#             return JsonResponse({'message': 'Department ID not provided.'}, status=400)

#         # Decode the Base64 image data
#         try:
#             format, imgstr = image_data.split(';base64,')
#             image_bytes = base64.b64decode(imgstr)
#             image = Image.open(BytesIO(image_bytes)).convert('RGB')
#         except Exception as e:
#             return JsonResponse({'message': 'Invalid image format.'}, status=400)

#         # Convert image to numpy array
#         image_np = np.array(image)

#         # Detect faces using dlib
#         faces = detector(image_np, 1)
#         if len(faces) != 1:
#             return JsonResponse({'message': 'No face or multiple faces detected.'}, status=400)

#         # Extract face landmarks and embeddings
#         face = faces[0]
#         shape = shape_predictor(image_np, face)
#         face_embedding = np.array(face_rec_model.compute_face_descriptor(image_np, shape))

#         # Get profiles in the department
#         profiles = Profile.objects.filter(department_id=department_id).exclude(face_embedding__isnull=True)
#         if not profiles.exists():
#             return JsonResponse({'message': 'No registered profiles in the department.'}, status=404)

#         # Recognize face by comparing embeddings
#         matched_user, min_distance = None, RECOGNITION_THRESHOLD  # Threshold for recognition
#         for profile in profiles:
#             try:
#                 known_embedding = np.array(profile.face_embedding, dtype=np.float64)
#                 distance = np.linalg.norm(face_embedding - known_embedding)
#                 if distance < min_distance:
#                     min_distance = distance
#                     matched_user = profile
#             except Exception:
#                 continue  # Skip profiles with invalid embeddings

#         if not matched_user:
#             return JsonResponse({'message': 'Face not recognized.'}, status=404)

#         matched_username = matched_user.user.username
#         matched_full_name = matched_user.user.get_full_name()
#         print(f"Matched user: {matched_username}, distance: {min_distance}")

#         try:
#             today = timezone.now().date()
#             last_attendance = check_last_attendance(matched_username, today)

#             # Additional debugging
#             if last_attendance:
#                 # print(f"Last attendance record: {last_attendance}")
#                 time_difference = get_time_difference(last_attendance)
#                 print(f"Time difference: {time_difference}")
#                 if time_difference < timedelta(minutes=ATTENDANCE_TIME_WINDOW):
#                     print('before:',last_attendance.status)
#                     if last_attendance.status == 'Absent':
#                         # Update attendance if previously marked absent
#                         last_attendance.status = 'Present'
#                         # print('after:',last_attendance.status)
#                         last_attendance.save()
#                         return JsonResponse({'message': f'Attendance updated to Present for {matched_username}.'}, status=200)
#                     return JsonResponse({'message': f'Attendance already marked for {matched_username}.'}, status=200)
#                 else:
#                     department = Department.objects.get(id=department_id)
#                     Attendance.objects.create(
#                     user_profile=matched_user,
#                     department=department,
#                     department_name=department.name,
#                     username=matched_username,
#                     fullname=matched_full_name,
#                     status='Present',
#                     )
#                     print(f"Attendance marked for {matched_username} in {department.name}")
#                     return JsonResponse({'message': f'Face recognized successfully for {matched_full_name} ({matched_username}) \n marked as Present'}, status=200)
#             else:
#                 print("No attendance record found")

#         except Exception as e:
#             print(f"Unexpected error: {str(e)}")

#         # Mark attendance
#         department = Department.objects.get(id=department_id)
#         print(f"Marking attendance for {matched_username} in {department.name}")
#         try:
#             Attendance.objects.create(
#                 user_profile=matched_user,
#                 department=department,
#                 department_name=department.name,
#                 username=matched_username,
#                 fullname=matched_full_name,
#                 status='Present',
#             )
#         except Exception as e:
#             print(f"Unexpected error: {str(e)}")
#         print(f"Attendance marked for {matched_username} in {department.name}")
#         return JsonResponse({'message': f'Face recognized successfully for {matched_full_name} ({matched_username}) \n marked as Present'}, status=200)
#         # return JsonResponse({'recognized_name': matched_username, 'full_name': matched_full_name}, status=200)

#     except Exception as e:
#         return JsonResponse({'error': f"An error occurred: {str(e)}"}, status=500)

def check_last_attendance(matched_username, today):
    try:
        # Expanded query to handle potential edge cases
        last_attendance = Attendance.objects.filter(
            Q(user_profile__user__username=matched_username) & 
            Q(date=today)
        ).order_by('-check_in_time').first()

        # Detailed logging and error handling
        if last_attendance:
            print(f"Last Attendance ID Found: {last_attendance.id}")
            return last_attendance

        else:
            print("No previous attendance record found for today.")
            return None

    except Exception as e:
        print(f"Error checking last attendance: {str(e)}")
        return None


# Correct way to calculate time difference
def get_time_difference(last_attendance):
    # Get current IST time
    current_time = timezone.now()
    
    # Ensure both times are timezone aware and in the same timezone
    last_attendance_time = datetime.combine(last_attendance.date, last_attendance.check_in_time)
    
    # Calculate time difference
    time_difference = current_time - last_attendance_time
    
    return time_difference  


@csrf_exempt
def register_face(request):
    if request.method == 'POST':
        try:
            # Parse the image data from the request
            data = json.loads(request.body)
            image_data = data.get('image')
            user_id = data.get('userID')

            if not image_data:
                return JsonResponse({'message': 'Image data not provided.'}, status=400)
            
            # Decode the Base64 image data
            format, imgstr = image_data.split(';base64,')
            image_bytes = base64.b64decode(imgstr)
            image = Image.open(BytesIO(image_bytes))

            # Convert the image to grayscale (8-bit)
            image = image.convert('L')  # 'L' mode is for 8-bit grayscale
            # image = image.convert('RGB')  # Ensure the image is in RGB mode

            print(f"Converted image mode: {image.mode}, size: {image.size}")

            # Convert the image to a format compatible with face_recognition
            image_np = np.array(image)
            print(f"Image NumPy array shape: {image_np.shape}, dtype: {image_np.dtype}")

            # Convert the grayscale image to 3-channel for dlib compatibility
            image_bgr = cv2.cvtColor(image_np, cv2.COLOR_RGB2BGR)

            # Resize the image to a standard size (optional, but might help)
            image_bgr = cv2.resize(image_bgr, (640, 480))

            # Confirm the dtype is uint8
            image_bgr = image_bgr.astype(np.uint8)
            print(f"bgr NumPy array shape: {image_bgr.shape}, dtype: {image_bgr.dtype}, Image type: {type(image_bgr)}")
            print(f"Pixel value range: {image_bgr.min()} to {image_bgr.max()}")
            # print(image_bgr)


            # Detect faces using dlib
            print("Detecting faces...")
            faces = detector(image_bgr, 1)
            print(f"Number of faces detected: {len(faces)}")
            if len(faces) != 1:
                return JsonResponse({'message': 'No face or multiple faces detected.'}, status=400)

            # Extract the face landmarks and embeddings
            print("Detecting landmarks...")
            shape = shape_predictor(image_bgr, faces[0])
            print(f"Landmarks detected: {shape.parts()}")

            print("Computing face descriptor...")
            face_embedding = np.array(face_rec_model.compute_face_descriptor(image_bgr, shape))
            print(f"Face embedding: {face_embedding}")

            # Save the face embedding to the user's profile
            print(user_id)
            try:
                user_profile = Profile.objects.get(user_id=user_id)
            except Profile.DoesNotExist:
                return JsonResponse({'message': 'Profile not found for the current user.'}, status=404)

            user_profile.face_embedding = face_embedding.tolist()
            user_profile.save()

            return JsonResponse({'message': 'Face registered successfully!'})

        except Exception as e:
            print(f"Error details: {str(e)}")
            return JsonResponse({'message': str(e)}, status=500)
    return JsonResponse({'message': 'Invalid request method.'}, status=405)


# def get_face_embeddings(request):
#     # Get the selected department from the request (e.g., via GET parameters)
#     department_id = request.GET.get('department_id', None)
#     print(department_id)
#     if department_id:
#         # Retrieve all user profiles from that department
#         user_profiles = Profile.objects.filter(department_id=Department.objects.get(id=department_id)).exclude(face_embedding__isnull=True)
#         print(user_profiles)
#     else:
#         # If no department is selected, return all users
#         user_profiles = Profile.objects.all()

#     embeddings = {}
#     for user_profile in user_profiles:
#         print(type (user_profile.face_embedding))
#         if user_profile.face_embedding:
#             try:
#                 # Check if face_embedding is in JSON format (convert to numpy array)
                
#                 # Convert binary data back to np.array
#                 embedding = np.array(user_profile.face_embedding, dtype=np.float64)
#                 print(user_profile.user)
#                 embeddings[str(user_profile.user)] = embedding.tolist()
#                 print('success')
#             except Exception as e:
#                     # Handle any errors in processing the face_embedding
#                     return JsonResponse({"error": f"Error processing face embedding: {str(e)}"}, status=500)
#         else:
#             # If no valid face_embedding, skip this profile
#             print('skipping')
#             continue

#     return JsonResponse({"department_id": department_id, "embeddings": embeddings})

