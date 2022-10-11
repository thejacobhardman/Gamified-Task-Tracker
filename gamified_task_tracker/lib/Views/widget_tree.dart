import 'package:flutter/material.dart';
import 'package:gamified_task_tracker/Views/auth.dart';
import 'package:gamified_task_tracker/pages/home_page.dart';
import 'package:gamified_task_tracker/pages/login_register_page.dart';
import 'package:gamified_task_tracker/pages/tasks_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return const LoginPage();
          }
        });
  }
}
