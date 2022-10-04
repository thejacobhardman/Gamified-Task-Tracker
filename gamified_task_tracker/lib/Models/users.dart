// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  Users({
    this.id,
    this.userName,
    this.password,
    this.firstName,
    this.lastName,
    this.email,
    this.points,
    this.team,
  });

  int? id;
  String? userName;
  String? password;
  String? firstName;
  String? lastName;
  String? email;
  int? points;
  int? team;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    id: json["id"],
    userName: json["user_name"],
    password: json["password"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    points: json["points"],
    team: json["team"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_name": userName,
    "password": password,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "points": points,
    "team": team,
  };
}
