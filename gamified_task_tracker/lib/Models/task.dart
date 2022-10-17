// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Task> taskFromJson(String str) => List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
  Task({
    this.id,
    required this.taskName,
    required this.description,
    this.completed,
    this.completedby,
    required this.valid,
    required this.dueDate,
    this.authorKey,
    this.team,
    required this.points,
  });

  int? id;
  String taskName;
  String description;
  bool? completed;
  String? completedby;
  bool valid;
  String dueDate;
  int? authorKey;
  int? team;
  int points;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    taskName: json["task_name"],
    description: json["description"],
    completed: json["completed"],
    completedby: json["completedby"],
    valid: json["valid"],
    dueDate: json["due_date"],
    authorKey: json["author_key"],
    team: json["team"],
    points: json["points"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "task_name": taskName,
    "description": description,
    "completed": completed,
    "completedby": completedby,
    "valid": valid,
    "due_date": dueDate,
    "author_key": authorKey,
    "team": team,
    "points": points,
  };
}
