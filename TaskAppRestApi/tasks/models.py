from django.db import models
import uuid
# from djongo import models

# Create your models here.


class Team(models.Model):
    team_name = models.CharField(max_length=70, blank=False, default='')
    team_code = models.CharField(
        blank=False, unique=True, max_length=6)


class User(models.Model):
    user_name = models.CharField(max_length=70, blank=False, unique=True)
    password = models.CharField(max_length=70, blank=False)
    first_name = models.CharField(
        max_length=70, blank=True, null=True, default=None)
    last_name = models.CharField(
        max_length=70, blank=True, null=True, default=None)
    email = models.EmailField(unique=True, blank=True, null=True, default=None)
    team = models.ForeignKey(
        Team, blank=True, null=True, default=None, on_delete=models.SET_NULL)
    points = models.IntegerField(blank=True, null=True, default=None)
    admin = models.BooleanField(default=False, editable=True)


class Task(models.Model):
    task_name = models.CharField(max_length=70, blank=False, default='')
    description = models.CharField(max_length=200, blank=False, default='')
    completed = models.BooleanField(default=False)
    completedby = models.CharField(max_length=70, blank=True, default='')
    valid = models.BooleanField(default=False)
    due_date = models.DateField()
    author_key = models.ForeignKey(User, on_delete=models.CASCADE)
    team = models.ForeignKey(Team, blank=False, on_delete=models.CASCADE)
    points = models.IntegerField()


'''
class Author(models.Model):
    name = models.CharField(max_length=70, blank=False)


class Book(models.Model):
    name = models.CharField(max_length=70, blank=False)
    author = models.ForeignKey(Author, on_delete=models.CASCADE)
'''
