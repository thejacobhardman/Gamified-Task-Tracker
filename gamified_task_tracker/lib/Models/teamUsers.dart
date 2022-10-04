// To parse this JSON data, do
//
//     final teamUsers = teamUsersFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<TeamUsers> teamUsersFromJson(String str) => List<TeamUsers>.from(json.decode(str).map((x) => TeamUsers.fromJson(x)));

String teamUsersToJson(List<TeamUsers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeamUsers {
  TeamUsers({
    required this.userName,
    this.firstName,
    this.lastName,
    required this.points,
  });

  String userName;
  String? firstName;
  String? lastName;
  int points;

  factory TeamUsers.fromJson(Map<String, dynamic> json) => TeamUsers(
    userName: json["user_name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    points: json["points"],
  );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "first_name": firstName,
    "last_name": lastName,
    "points": points,
  };
}
