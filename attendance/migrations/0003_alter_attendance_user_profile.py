# Generated by Django 5.1.4 on 2024-12-23 14:10

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("attendance", "0002_remove_attendance_name_attendance_department_and_more"),
        ("users", "0003_profile_face_embedding_alter_profile_user"),
    ]

    operations = [
        migrations.AlterField(
            model_name="attendance",
            name="user_profile",
            field=models.ForeignKey(
                null=True,
                on_delete=django.db.models.deletion.CASCADE,
                related_name="attendances",
                to="users.profile",
            ),
        ),
    ]