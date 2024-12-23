# users/views.py
import numpy as np
from PIL import Image
from io import BytesIO
from django.views.decorators.csrf import csrf_exempt
import json, base64, cv2, dlib
from django.db import IntegrityError
from django.shortcuts import render, redirect, get_object_or_404
from .models import Department, Profile
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse, Http404
from django.contrib import messages

# Load dlib's face detection and embedding models
detector = dlib.get_frontal_face_detector()
face_rec_model = dlib.face_recognition_model_v1('utilities/dlib_face_recognition_resnet_model_v1.dat')
shape_predictor = dlib.shape_predictor('utilities/shape_predictor_68_face_landmarks.dat')

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

            # Retrieve the uploaded file
            # user_id = request.FILES.get('userID')
            # print(user_id)
            # uploaded_file = request.FILES.get('image')
            # if not uploaded_file:
            #     return JsonResponse({'message': 'No image file provided.'}, status=400)

            # # Load the image using PIL
            # image = Image.open(uploaded_file)
            # print(f"actual image mode: {image.mode}, size: {image.size}")

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

            # # Extract face embeddings
            # face_locations = face_recognition.face_locations(image_np)
            # if not face_locations:
            #     return JsonResponse({'message': 'No faces detected in the image.'}, status=400)

            # print("face loc generated:", face_locations)
            # face_encodings = face_recognition.face_encodings(image_np, face_locations)
            # print("face encodings generated")

            # if len(face_encodings) != 1:
            #     return JsonResponse({'message': 'No face or multiple faces detected.'}, status=400)

            # face_embedding = face_encodings[0].tolist()  # Convert to a list for JSON serialization

            # Save the embedding to the user's profile
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
