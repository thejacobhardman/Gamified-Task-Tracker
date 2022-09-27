import 'package:flutter/material.dart';
import 'add-task.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CreateTaskPage(),
    );
  }
}