from rest_framework import serializers
from tasks.models import *

'''
class AuthorSerializer(serializers.ModelSerializer):

    # id = serializers.CharField()

    class Meta:
        model = Author
        fields = ('id',
                  'name',)


class BookSerializer(serializers.ModelSerializer):

    class Meta:
        model = Book
        fields = ('id',
                  'name',
                  'author',)
'''


class UserAuthSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('user_name',
                  'password',)


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('user_name',
                  'first_name',
                  'last_name',
                  'email',
                  'team',
                  'points')


class TaskSerializer(serializers.ModelSerializer):
    class Meta:
        model = Task
        fields = ('task_name',
                  'description',
                  'completed',
                  'due_date',
                  'author_key',
                  'points')


class TeamSerializer(serializers.ModelSerializer):
    class Meta:
        model = Team
        fields = ('team_name',
                  'team_code')
