from django.urls import re_path
from tasks import views

urlpatterns = [
    re_path(r'^user$', views.users),
    re_path(r'^teamusers$', views.team_users),
    re_path(r'^team$', views.teams),
    re_path(r'^task$', views.tasks),
    re_path(r'^users$', views.allusers),
    re_path(r'^teams$', views.allteams),
    re_path(r'^tasks$', views.alltasks),
    #re_path(r'^userauth$', views.userauth)
    #re_path(r'^authors$', views.author),
    #re_path(r'^authors/(?P<pk>[0-9]+)$', views.single_author),
    #re_path(r'^books$', views.book),
    #re_path(r'^authorbooks$', views.author_books),
    #re_path(r'^/tutorials/(?P<pk>[0-9]+)$', views.task_detail),
    #re_path(r'^/tutorials/published$', views.task_published)
]
