import 'package:flutter/material.dart';
import 'package:gamified_task_tracker/Pages/only_for_admin.dart';

import '../Models/task.dart';
import '../Models/teamTasks.dart';
import '../Models/users.dart';
import '../Views/RemoteAccess.dart';
import '../Views/style.dart';

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
        backgroundColor: primaryColor,
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
            TextButton(
              child: Text("Approve"),
              onPressed: () async => {
                _approveTask(),
                Navigator.of(context).pop(),
              },
            ),
            TextButton(
              child: Text("Deny"),
              onPressed: () async => {
                _denyTask(),
                Navigator.of(context).pop(),
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () async => {
                _deleteTask(context),
                Navigator.of(context).pop(),
              },
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> _approveTask() async {
    List<Users>? taskUserList = await access.getUsers(widget.task.completedby);
    var taskUser = taskUserList![0];
    var closedTask = Task(
      id: widget.task.id,
      taskName: widget.task.taskName,
      description: widget.task.description,
      completed: true,
      completedby: widget.task.completedby,
      valid: true,
      dueDate: widget.task.dueDate,
      authorKey: widget.task.authorKey,
      team: widget.task.team,
      points: widget.task.points,
    );
    var currentUser = Users(
        id: taskUser.id,
        userName: taskUser.userName,
        password: taskUser.password,
        firstName: taskUser.firstName,
        lastName: taskUser.lastName,
        email: taskUser.email,
        points: taskUser.points! + widget.task.points,
        admin: taskUser.admin,
        team: taskUser.team);
    var name = taskUser.userName;
    var response = await access
        .put("/user?username=$name", currentUser)
        .catchError((err) {});
    response = await access
        .put("/task?task_id=${widget.task.id}", closedTask)
        .catchError((err) {});
    if (response == null) {
      print("null");
      return;
    }
    debugPrint("Successful");
  }

  Future<dynamic> _denyTask() async {
    var denyTask = Task(
      id: widget.task.id,
      taskName: widget.task.taskName,
      description: widget.task.description,
      completed: false,
      completedby: widget.task.completedby,
      valid: false,
      dueDate: widget.task.dueDate,
      authorKey: widget.task.authorKey,
      team: widget.task.team,
      points: widget.task.points,
    );
    var response = await access
        .put("/task?task_id=${widget.task.id}", denyTask)
        .catchError((err) {});
    if (response == null) {
      print("null");
      return;
    }
    debugPrint("Successful");
  }

  Future<dynamic> _deleteTask(context) async {
    var response = await access.delete("/task?task_id=${widget.task.id}");
    if (response == null) {
      print("null");
      return;
    }
    debugPrint("Successfully deleted task");
  }

  openDeleteAlert(BuildContext context) {
    Widget confirmButton = TextButton(
      child: Text("Confirm"),
      onPressed: () async => {
        _deleteTask(context),
        Navigator.of(context).pop(),
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () => {Navigator.of(context).pop()},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert!"),
      content:
          Text("This will delete the task. NOTE: This action is irreversable"),
      actions: [
        confirmButton,
        cancelButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
