// To parse this JSON data, do
//
//     final teams = teamsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Teams> teamsFromJson(String str) =>
    List<Teams>.from(json.decode(str).map((x) => Teams.fromJson(x)));

String teamsToJson(List<Teams> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Teams {
  Teams({
    this.id,
    required this.teamName,
    required this.teamCode,
  });

  int? id;
  String teamName;
  String teamCode;

  factory Teams.fromJson(Map<String, dynamic> json) => Teams(
        id: json["id"],
        teamName: json["team_name"],
        teamCode: json["team_code"],
      );

  Map<String, dynamic> toJson() => {
        "team_name": teamName,
        "team_code": teamCode,
      };
}
