import 'package:flutter/material.dart';
import 'create_task.dart';
import 'edit_account.dart';
import 'create-account.dart';
import 'login-page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CreateAccountPage(),
    );
  }
}