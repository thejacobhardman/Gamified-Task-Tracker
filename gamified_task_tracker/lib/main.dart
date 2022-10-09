import 'package:flutter/material.dart';
import 'pages/create_task.dart';
import 'pages/edit_account.dart';
import 'pages/create_account.dart';
import 'pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}