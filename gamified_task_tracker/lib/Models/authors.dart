// To parse this JSON data, do
//
//     final authors = authorsFromJson(jsonString);
import 'dart:convert';

List<Authors> authorsFromJson(String str) => List<Authors>.from(json.decode(str).map((x) => Authors.fromJson(x)));

String authorsToJson(List<Authors> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Authors {
  Authors({

    this.id,
    required this.name,
  });

  int? id;
  String name;

  factory Authors.fromJson(Map<String, dynamic> json) => Authors(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
