import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:gamified_task_tracker/Models/authors.dart';
import 'package:gamified_task_tracker/Models/task.dart';
import 'package:gamified_task_tracker/Models/teamUsers.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'Models/books.dart';
import 'Models/teams.dart';
import 'Models/users.dart';

class RemoteAccess {
  Client client = http.Client();
  String api = "http://10.0.2.2:8000";


  Future<List<Tasks>?> getTasks() async {
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/todos');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return tasksFromJson(json);
    }
  }

  Future<dynamic> post(String branch, dynamic object) async {
    var uri = Uri.parse(api + branch);
    var payload = json.encode(object);
    var response = await client.post(uri, body: payload);
    if (response.statusCode == 201) {
      return response.body;
    }
  }

  Future<dynamic> put(String branch, dynamic object) async {
    var uri = Uri.parse(api + branch);
    var payload = json.encode(object);
    var response = await client.put(uri, body: payload);
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  Future<List<Users>?> getUsers(String? email) async {
    var uri = Uri.parse("$api/user?email=$email");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      debugPrint("Successful");
      var json = response.body;
      return usersFromJson(json);
    } else {
      debugPrint("Not Successful");
      return null;
    }
  }

  Future<List<TeamUsers>?> getTeamUsers(int? id) async {
    var uri = Uri.parse("$api/teamusers?teamid=$id");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      debugPrint("Successful");
      var json = response.body;
      return teamUsersFromJson(json);
    } else {
      debugPrint("Not Successful");
      return null;
    }
  }

  Future<List<Teams>?> getTeams(String? branch) async {
    var uri = Uri.parse("$api$branch");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      debugPrint("Successful");
      var json = response.body;
      return teamsFromJson(json);
    } else {
      debugPrint("Not Successful");
      return null;
    }
  }

  Future<List<Authors>?> delete(String branch) async {
    var uri = Uri.parse(api + branch);
    var response = await client.delete(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return authorsFromJson(json);
    }
  }
}
