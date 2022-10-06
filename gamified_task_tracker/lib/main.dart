import 'package:flutter/material.dart';
import 'create_task.dart';
import 'edit_account.dart';
import 'create-account.dart';
import 'login-page.dart';
import 'view_tasks.dart';
import 'home.dart';

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