// To parse this JSON data, do
//
//     final books = booksFromJson(jsonString);

import 'dart:convert';

List<Books> booksFromJson(String str) => List<Books>.from(json.decode(str).map((x) => Books.fromJson(x)));

String booksToJson(List<Books> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Books {
  Books({
    this.id,
    required this.name,
    this.author,
  });

  int? id;
  String name;
  int? author;

  factory Books.fromJson(Map<String, dynamic> json) => Books(
    id: json["id"],
    name: json["name"],
    author: json["author"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "author": author,
  };
}
