# Generated by Django 4.1 on 2022-10-09 04:50

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tasks', '0005_alter_team_team_code'),
    ]

    operations = [
        migrations.AlterField(
            model_name='task',
            name='completedby',
            field=models.CharField(blank=True, default='', max_length=70),
        ),
    ]
