// To parse this JSON data, do
//
//     final teamUsers = teamUsersFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<TeamTasks> teamTasksFromJson(String str) =>
    List<TeamTasks>.from(json.decode(str).map((x) => TeamTasks.fromJson(x)));

String teamUsersToJson(List<TeamTasks> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeamTasks {
  TeamTasks({
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

  factory TeamTasks.fromJson(Map<String, dynamic> json) => TeamTasks(
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
