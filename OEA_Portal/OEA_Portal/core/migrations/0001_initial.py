# Generated by Django 4.1.3 on 2022-12-06 12:19

from django.db import migrations, models
import uuid


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='InstallationLogs',
            fields=[
                ('id', models.UUIDField(default=uuid.uuid4, primary_key=True, serialize=False)),
                ('request_id', models.CharField(max_length=20)),
                ('action', models.CharField(max_length=20)),
                ('message', models.TextField(max_length=500)),
                ('timestamp', models.DateTimeField(auto_now=True)),
            ],
        ),
        migrations.CreateModel(
            name='TableMetadata',
            fields=[
                ('id', models.IntegerField(auto_created=True, primary_key=True, serialize=False)),
                ('table_name', models.CharField(max_length=100)),
                ('column_name', models.CharField(max_length=100)),
                ('column_type', models.CharField(max_length=20)),
                ('constraint', models.CharField(max_length=20)),
                ('pseuodynimization', models.CharField(max_length=20)),
            ],
        ),
    ]
