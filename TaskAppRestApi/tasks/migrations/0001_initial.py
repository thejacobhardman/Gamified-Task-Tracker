# Generated by Django 4.1 on 2022-10-05 22:54

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Team',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('team_name', models.CharField(default='', max_length=70)),
                ('team_code', models.CharField(default='551618', editable=False, max_length=6, unique=True)),
            ],
        ),
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_name', models.CharField(max_length=70, unique=True)),
                ('password', models.CharField(max_length=70)),
                ('first_name', models.CharField(blank=True, default=None, max_length=70, null=True)),
                ('last_name', models.CharField(blank=True, default=None, max_length=70, null=True)),
                ('email', models.EmailField(blank=True, default=None, max_length=254, null=True, unique=True)),
                ('points', models.IntegerField(blank=True, default=None, null=True)),
                ('admin', models.BooleanField(default=False)),
                ('team', models.ForeignKey(blank=True, default=None, null=True, on_delete=django.db.models.deletion.PROTECT, to='tasks.team')),
            ],
        ),
        migrations.CreateModel(
            name='Task',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('task_name', models.CharField(default='', max_length=70)),
                ('description', models.CharField(default='', max_length=200)),
                ('completed', models.BooleanField(default=False)),
                ('valid', models.BooleanField(default=False)),
                ('due_date', models.DateField()),
                ('points', models.IntegerField()),
                ('author_key', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='tasks.user')),
                ('team', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='tasks.team')),
            ],
        ),
    ]