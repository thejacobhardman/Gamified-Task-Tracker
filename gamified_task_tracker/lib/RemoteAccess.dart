import 'dart:convert';

import 'package:gamified_task_tracker/authors.dart';
import 'package:gamified_task_tracker/books.dart';
import 'package:gamified_task_tracker/task.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

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
    var uri = Uri.parse(api+branch);
    var payload = json.encode(object);
    var response = await client.post(uri, body: payload);
    if (response.statusCode == 201){
      return response.body;
    }
  }

  Future<dynamic> put(String branch, dynamic object) async {
    var uri = Uri.parse(api+branch);
    var payload = json.encode(object);
    var response = await client.put(uri, body: payload);
    if (response.statusCode == 200){
      return response.body;
    }
  }

  Future<List<Books>?> getBooks(String branch) async {
    var uri = Uri.parse(api+branch);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return booksFromJson(json);
    }
  }

  Future<List<Authors>?> getAuthors(String branch) async {
    var uri = Uri.parse(api+branch);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return authorsFromJson(json);
    }
  }

  Future<List<Authors>?> delete(String branch) async {
    var uri = Uri.parse(api+branch);
    var response = await client.delete(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return authorsFromJson(json);
    }
  }
}
