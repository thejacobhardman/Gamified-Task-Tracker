// To parse this JSON data, do
//
//     final tasks = tasksFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Tasks> tasksFromJson(String str) => List<Tasks>.from(json.decode(str).map((x) => Tasks.fromJson(x)));

String tasksToJson(List<Tasks> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tasks {
  Tasks({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  int userId;
  int id;
  String title;
  bool completed;

  factory Tasks.fromJson(Map<String, dynamic> json) => Tasks(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    completed: json["completed"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "completed": completed,
  };
}