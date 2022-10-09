import 'package:flutter/material.dart';
import 'package:gamified_task_tracker/RemoteAccess.dart';

import '../Models/task.dart';
import '../Models/teamTasks.dart';
import '../Models/users.dart';

class CompletedTaskDetailPage extends StatefulWidget {
  CompletedTaskDetailPage(this.task, this.user, {super.key});
  final TeamTasks task;
  final Users user;

  @override
  State<CompletedTaskDetailPage> createState() => _CompletedTaskDetailPage();
}

class _CompletedTaskDetailPage extends State<CompletedTaskDetailPage> {
  RemoteAccess access = new RemoteAccess();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.task.taskName),
          backgroundColor: Color.fromARGB(255, 174, 0, 255),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Text('Description', style: Theme.of(context).textTheme.headline6),
              Text(widget.task.description),
              SizedBox(height: 12),
              Text('Due', style: Theme.of(context).textTheme.headline6),
              Text(widget.task.dueDate),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: completeTask,
          backgroundColor: Color.fromARGB(255, 191, 0, 255),
          child: Icon(Icons.check_circle),
        ));
  }

  Future<dynamic> completeTask() async {
    var completedTask = Task(
      id: widget.task.id,
      taskName: widget.task.taskName,
      description: widget.task.description,
      completed: false,
      completedby: widget.user.userName,
      valid: false,
      dueDate: widget.task.dueDate,
      authorKey: widget.task.authorKey,
      team: widget.task.team,
      points: widget.task.points,
    );
    var response = await access
        .put("/task?task_id=${widget.task.id}", completedTask)
        .catchError((err) {});
    if (response == null) {
      print("null");
      return;
    }
    debugPrint("Successful");
  }
}
