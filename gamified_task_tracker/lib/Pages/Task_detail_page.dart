import 'package:flutter/material.dart';

import '../Models/teamTasks.dart';

class TaskDetailPage extends StatelessWidget {
  final TeamTasks task;
  const TaskDetailPage(this.task, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.taskName),
      ),
      body: Center(
        child: Text(task.id.toString()),
      ),
    );
  }
}
