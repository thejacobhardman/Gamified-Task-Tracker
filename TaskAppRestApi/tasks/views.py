from django.shortcuts import render

from django.http.response import JsonResponse
from rest_framework.parsers import JSONParser
from rest_framework import status

from tasks.models import *
from tasks.serializers import *
from rest_framework.decorators import api_view


""" @api_view(['GET'])
def userauth(request):

    # Example: [http://localhost:8000/authors], no body
    # Example: [http://localhost:8000/authors?name=Harry Jenkins], no body
    if request.method == 'GET':
        fields = ('user_name', 'password')
        user = User.objects.all().only('user_name', 'password')
        name = request.GET.get('user_name', None)
        if name is not None:
            user = user.filter(user_name=name)
        users_serializer = SimpleUserSerializer(user, many=True, fields=fields)
        return JsonResponse(users_serializer.data, safe=False) """


@api_view(['GET', 'POST', 'PUT', 'DELETE'])
def users(request):

    # Example: [http://localhost:8000/user?username=Harry Jenkins], no body
    if request.method == 'GET':
        users = User.objects.all()
        email = request.GET.get('email', None)
        if email is not None:
            users = users.filter(email=email)
            users_serializer = SimpleUserSerializer(users, many=True)
            return JsonResponse(users_serializer.data, safe=False)
        return JsonResponse({'message': 'No username paramater passed in URL.'}, status=status.HTTP_400_BAD_REQUEST)

    # Example: [http://localhost:8000/user], body has JSON user data
    elif request.method == 'POST':
        user_data = JSONParser().parse(request)
        user_serializer = SimpleUserSerializer(data=user_data)
        if user_serializer.is_valid():
            user_serializer.save()
            return JsonResponse(user_serializer.data, status=status.HTTP_201_CREATED)
        return JsonResponse(user_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    # Example: [http://localhost:8000/user?username=Harry Jenkins], no body
    if request.method == 'PUT':
        fields = ('user_name', 'first_name', 'last_name', 'email', 'team', 'points')
        try:
            username = request.GET.get('username', None)
            user = User.objects.get(user_name=username)
        except User.DoesNotExist:
            return JsonResponse({'message': 'The user does not exist'}, status=status.HTTP_404_NOT_FOUND)
        user_data = JSONParser().parse(request)
        user_serializer = SimpleUserSerializer(
            user, data=user_data, fields=fields, partial=True)
        if user_serializer.is_valid():
            user_serializer.save()
            return JsonResponse(user_serializer.data)
        return JsonResponse(user_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    # Example: [http://localhost:8000/user?username=Harry Jenkins], no body
    elif request.method == 'DELETE':
        users = User.objects.all()
        name = request.GET.get('username', None)
        if name is not None:
            users = users.filter(user_name=name)
            count = users.delete()
            return JsonResponse({'message': '{} Users were deleted successfully.'.format(count[0])}, status=status.HTTP_204_NO_CONTENT)
        return JsonResponse({'message': 'No username paramater passed in URL.'}, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST', 'GET'])
def teams(request):

    # Example: [http://localhost:8000/team?team_code=ABC123], no body
    if request.method == 'GET':
        fullTeam = Team.objects.all()
        teamCode = request.GET.get('team_code', None)

        if teamCode is not None:
            fullTeam = fullTeam.filter(team_code=teamCode)
        team_serializer = TeamSerializer(fullTeam, many=True)
        return JsonResponse(team_serializer.data, safe=False)

    # Example: [http://localhost:8000/team], body has JSON user data
    if request.method == 'PUT':
        team_data = JSONParser().parse(request)
        team_serializer = TeamSerializer(data=team_data)
        if team_serializer.is_valid():
            team_serializer.save()
            return JsonResponse(team_serializer.data)
        return JsonResponse(team_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    # Example: [http://localhost:8000/team], body has JSON user data
    if request.method == 'POST':
        team_data = JSONParser().parse(request)
        team_serializer = TeamSerializer(data=team_data)
        if team_serializer.is_valid():
            team_serializer.save()
            return JsonResponse(team_serializer.data, status=status.HTTP_201_CREATED)
        return JsonResponse(team_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    # Example: [http://localhost:8000/team?team_code=ABC123], no body
    elif request.method == 'DELETE':
        teams = Team.objects.all()
        teamCode = request.GET.get('team_code', None)
        if teamCode is not None:
            teams = teams.filter(team_code=teamCode)
            count = teams.delete()
            if count > 0:
                return JsonResponse({'message': 'Team was deleted successfully.'}, status=status.HTTP_204_NO_CONTENT)
            else:
                return JsonResponse({'message': 'Team does not exist.'}, status=status.HTTP_404_NOT_FOUND)
        return JsonResponse({'message': 'No team_name paramater passed in URL.'}, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def team_users(request):

    # Example: [http://localhost:8000/teamusers?teamid=1], no body
    if request.method == 'GET':
        fields = ('user_name', 'first_name', 'last_name', 'points')
        users = User.objects.all()
        team_id = request.GET.get('teamid', None)
        if team_id is not None:
            users = users.filter(team=team_id)
            users_serializer = SimpleUserSerializer(
                users, many=True, fields=fields)
            return JsonResponse(users_serializer.data, safe=False)
        return JsonResponse({'message': 'No teamname paramater passed in URL.'}, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST', 'PUT', 'GET', 'DELETE'])
def tasks(request):

    # Example: [http://localhost:8000/task?task_id=3], no body
    if request.method == 'GET':
        taskID = request.GET.get('task_id', None)

        if taskID is not None:
            task = Task.objects.get(pk=taskID)
        task_serializer = TaskSerializer(task, many=True)
        return JsonResponse(task_serializer.data, safe=False)

    # Example: [http://localhost:8000/task], body has JSON user dat
    if request.method == 'PUT':
        task_data = JSONParser().parse(request)
        task_serializer = TaskSerializer(data=task_data)
        if task_serializer.is_valid():
            task_serializer.save()
            return JsonResponse(task_serializer.data)
        return JsonResponse(task_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    # Example: [http://localhost:8000/task], body has JSON user data
    if request.method == 'POST':
        task_data = JSONParser().parse(request)
        task_serializer = TaskSerializer(data=task_data)
        if task_serializer.is_valid():
            task_serializer.save()
            return JsonResponse(task_serializer.data, status=status.HTTP_201_CREATED)
        return JsonResponse(task_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    # Example: [http://localhost:8000/task?task_id=3], no body
    elif request.method == 'DELETE':
        taskID = request.GET.get('task_id', None)
        if taskID is not None:
            task = Task.object.get(pk=taskID)
            count = task.delete()
            if count > 0:
                return JsonResponse({'message': 'Task was deleted successfully.'}, status=status.HTTP_204_NO_CONTENT)
            else:
                return JsonResponse({'message': 'Task does not exist.'}, status=status.HTTP_404_NOT_FOUND)
        return JsonResponse({'message': 'No task_name paramater passed in URL.'}, status=status.HTTP_400_BAD_REQUEST)


'''
@api_view(['GET', 'POST', 'DELETE'])
def book(request):

    # Example: [http://localhost:8000/books], no body
    # Example: [http://localhost:8000/books?name=Harry Jenkin's Book about Agriculture], no body
    if request.method == 'GET':
        books = Book.objects.all()
        book_name = request.GET.get('name', None)
        if book_name is not None:
            books = books.filter(name=book_name)
        books_serializer = BookSerializer(books, many=True)
        return JsonResponse(books_serializer.data, safe=False)

    # Example: [http://localhost:8000/books], body has JSON book data
    elif request.method == 'POST':
        book_data = JSONParser().parse(request)
        book_serializer = BookSerializer(data=book_data)
        if book_serializer.is_valid():
            book_serializer.save()
            return JsonResponse(book_serializer.data, status=status.HTTP_201_CREATED)
        return JsonResponse(book_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    # Example: [http://localhost:8000/books], no body, KILLS EVERYTHING
    # Example: [http://localhost:8000/books?name=Harry Jenkin's Book about Agriculture], no body
    elif request.method == 'DELETE':
        books = Book.objects.all()
        book_name = request.GET.get('name', None)
        if book_name is not None:
            books = books.filter(name=book_name)
        count = books.delete()
        return JsonResponse({'message': '{} Books were deleted successfully!'.format(count[0])}, status=status.HTTP_204_NO_CONTENT)


@api_view(['GET', 'DELETE'])
def author_books(request):

    # Example: [http://localhost:8000/authorbooks?author_id=3], no body
    if request.method == 'GET':
        books = Book.objects.all()

        author_id = request.GET.get('author_id', None)
        if author_id is not None:
            books = books.filter(author=author_id)

            books_serializer = BookSerializer(books, many=True)
            return JsonResponse(books_serializer.data, safe=False)
        else:
            return JsonResponse({'message': 'Missing author_id field.'}, status=status.HTTP_204_NO_CONTENT)
        # 'safe=False' for objects serialization

    # Example: [http://localhost:8000/authorbooks?author_id=3], no body
    elif request.method == 'DELETE':
        books = Book.objects.all()

        author_id = request.GET.get('author_id', None)
        if author_id is not None:
            books = books.filter(author=author_id)
            count = books.delete()
            return JsonResponse({'message': '{} Books were deleted successfully!'.format(count[0])}, status=status.HTTP_204_NO_CONTENT)
        else:
            return JsonResponse({'message': 'Missing author_id field.'}, status=status.HTTP_204_NO_CONTENT)


@api_view(['GET', 'PUT', 'DELETE'])
def single_author(request, pk):

    try:
        author = Author.objects.get(pk=pk)
    except Author.DoesNotExist:
        return JsonResponse({'message': 'The author does not exist'}, status=status.HTTP_404_NOT_FOUND)

    # Example: [http://localhost:8000/authors/3], no body
    if request.method == 'GET':
        authors_serializer = AuthorSerializer(author)
        return JsonResponse(authors_serializer.data)

    elif request.method == 'PUT':
        author_data = JSONParser().parse(request)
        author_serializer = AuthorSerializer(
            author)
        if author_serializer.is_valid():
            author_serializer.save()
            return JsonResponse(author_serializer.data)
        return JsonResponse(author_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    # Example: [http://localhost:8000/authors/3], no body
    elif request.method == 'DELETE':
        author.delete()
        return JsonResponse({'message': 'Author was deleted successfully.'}, status=status.HTTP_204_NO_CONTENT)



@api_view(['GET', 'POST', 'DELETE'])
def tutorial_list(request):
    # GET list of tutorials, POST a new tutorial, DELETE all tutorials

    # Alternate GET that searches for conditional entries rather than all entries
    """ if request.method == 'GET':
        tutorials = Tutorial.objects.all()

        title = request.GET.get('title', None)
        if title is not None:
            tutorials = tutorials.filter(title__icontains=title)

        tutorials_serializer = TutorialSerializer(tutorials, many=True)
        return JsonResponse(tutorials_serializer.data, safe=False)
        # 'safe=False' for objects serialization """

    if request.method == 'GET':
        tutorials = Tutorial.objects.all()

        title = request.GET.get('title', None)
        if title is not None:
            tutorials = tutorials.filter(title__icontains=title)

        tutorials_serializer = TutorialSerializer(tutorials, many=True)
        return JsonResponse(tutorials_serializer.data, safe=False)
        # 'safe=False' for objects serialization
    elif request.method == 'POauthor = JSONParser().parse(request)
        author_serializer = TutorialSerializeauthor)
        if author_serializer.is_valid():
            author_serializer.save()
            return JsonResponse(author_serializer.data, status=status.HTTP_201_CREATED)
        return JsonResponse(author_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    elif request.method == 'DELETE':
        count = Tutorial.objects.all().delete()
        return JsonResponse({'message': '{} Tutorials were deleted successfully!'.format(count[0])}, status=status.HTTP_204_NO_CONTENT)


@api_view(['GET', 'PUT', 'DELETE'])
def tutorial_detail(request, pk):
    # find tutorial by pk (id)
    try:
        tutorial = Tutorial.objects.get(pk=pk)

        if request.method == 'GET':
            author_serializer = TutorialSerializer(tutorial)
            return JsonResponse(author_serializer.data)
        elif request.method == 'PUauthor = JSONParser().parse(request)
            author_serializer = TutorialSerializer(
                tutorialauthor)
            if author_serializer.is_valid():
                author_serializer.save()
                return JsonResponse(author_serializer.data)
            return JsonResponse(author_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        elif request.method == 'DELETE':
            tutorial.delete()
            return JsonResponse({'message': 'Tutorial was deleted successfully!'}, status=status.HTTP_204_NO_CONTENT)
    except Tutorial.DoesNotExist:
        return JsonResponse({'message': 'The tutorial does not exist'}, status=status.HTTP_404_NOT_FOUND)

    # GET / PUT / DELETE tutorial


@api_view(['GET'])
def tutorial_list_published(request):
    # GET all published tutorials
    tutorials = Tutorial.objects.filter(published=True)

    if request.method == 'GET':
        tutorials_serializer = TutorialSerializer(tutorials, many=True)
        return JsonResponse(tutorials_serializer.data, safe=False)
'''
