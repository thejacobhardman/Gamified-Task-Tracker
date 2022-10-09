import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:gamified_task_tracker/Models/authors.dart';
import 'package:gamified_task_tracker/Models/task.dart';
import 'package:gamified_task_tracker/Models/teamUsers.dart';
import 'package:gamified_task_tracker/Models/teamTasks.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'Models/books.dart';
import 'Models/teams.dart';
import 'Models/users.dart';

class RemoteAccess {
  Client client = http.Client();
  String api = "http://10.0.2.2:8000";

  Future<dynamic> post(String branch, dynamic object) async {
    var uri = Uri.parse(api + branch);
    var payload = json.encode(object);
    var response = await client.post(uri, body: payload);
    if (response.statusCode == 201) {
      print("successful POST");
      print("${response.body}");
      return response.body;
    } else {
      print("Error happened with POST");
      print("${response.body}");
    }
  }

  Future<dynamic> put(String branch, dynamic object) async {
    var uri = Uri.parse(api + branch);
    var payload = json.encode(object);
    var response = await client.put(uri, body: payload);
    if (response.statusCode == 200) {
      return response.body;
    }
    if (response.statusCode == 404) {
      print(response.statusCode);
    }
  }

  Future<List<Users>?> getUsers(String? email) async {
    var uri = Uri.parse("$api/user?email=$email");
    var response = await client.get(uri);
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      debugPrint("Successful");
      var json = response.body;
      return usersFromJson(json);
    } else {
      debugPrint("User Not Successful");
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
      debugPrint("Team User Not Successful");
      return null;
    }
  }

  Future<List<TeamTasks>?> getTeamTasks(int? id) async {
    var uri = Uri.parse("$api/teamtasks?team_id=$id");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      debugPrint("Successful");
      var json = response.body;
      return teamTasksFromJson(json);
    } else {
      debugPrint("Team Tasks Not Successful");
      return null;
    }
  }

  Future<List<Teams>?> getTeams(String? branch) async {
    var uri = Uri.parse("$api/team?team_code=$branch");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      debugPrint("Successful");
      var json = response.body;
      return teamsFromJson(json);
    } else {
      debugPrint("Team Not Successful");
      return null;
    }
  }

  Future<List<Teams>?> getTeamsById(int? branch) async {
    var uri = Uri.parse("$api/teamid?team_id=$branch");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      debugPrint("Successful");
      var json = response.body;
      return teamsFromJson(json);
    } else {
      debugPrint("Team Not Successful");
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

  Future getAllTeams() async {
    var uri = Uri.parse("$api/team?");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      debugPrint("Successful");
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      debugPrint("Team Not Successful");
      return null;
    }
  }
}
