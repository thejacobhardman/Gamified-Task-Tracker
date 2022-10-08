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


class DynamicUserSerializer(serializers.ModelSerializer):
    def __init__(self, *args, **kwargs):
        # Don't pass the 'fields' arg up to the superclass
        fields = kwargs.pop('fields', None)

        # Instantiate the superclass normally
        super(DynamicUserSerializer, self).__init__(*args, **kwargs)

        if fields is not None:
            # Drop any fields that are not specified in the `fields` argument.
            allowed = set(fields)
            existing = set(self.fields.keys())
            for field_name in existing - allowed:
                self.fields.pop(field_name)


class SimpleUserSerializer(DynamicUserSerializer):
    class Meta:
        model = User
        fields = '__all__'
        '''fields = ('user_name',
                  'first_name',
                  'last_name',
                  'email',
                  'team',
                  'points')'''


class TaskSerializer(serializers.ModelSerializer):
    class Meta:
        model = Task
        fields = ('id',
                  'task_name',
                  'description',
                  'completed',
                  'due_date',
                  'author_key',
                  'points')


class TeamSerializer(serializers.ModelSerializer):
    class Meta:
        model = Team
        fields = ('id',
                  'team_name',
                  'team_code')
