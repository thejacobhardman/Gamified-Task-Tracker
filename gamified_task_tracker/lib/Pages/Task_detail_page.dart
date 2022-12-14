import 'package:flutter/material.dart';


import '../Models/task.dart';
import '../Models/teamTasks.dart';
import '../Models/users.dart';
import '../Views/RemoteAccess.dart';
import '../Views/style.dart';
import '../widgets/ttform.dart';
import '../widgets/ttscaffold.dart';


class TaskDetailPage extends StatefulWidget {
  TaskDetailPage(this.task, this.user, {super.key});
  final TeamTasks task;
  final Users user;

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {

  RemoteAccess access = new RemoteAccess();

  @override
  Widget build(BuildContext context) {

    return TTScaffold(
      title: widget.task.taskName,
      body: TTForm(
        children: [
          const TTText(
            'Description', 
            thickness: FontWeight.w800,
            size: 20,
            ),
          TTText(widget.task.taskName),

          TTFormElement(child:Container()),

          const TTText(
            'Points', 
            thickness: FontWeight.w800,
            size: 20,
            ),
          TTText(widget.task.points.toString()),

          TTFormElement(child:Container()),

          const TTText(
            'Due', 
            thickness: FontWeight.w800,
            size: 20,
            ),
          TTText(widget.task.dueDate),

          TTFormElement(child:Container()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: completeTask,
          backgroundColor: createColor,
          child: Icon(Icons.check_circle),
        ),
    );
  }

  Future<dynamic> completeTask() async {
    var completedTask = Task(
      id: widget.task.id,
      taskName: widget.task.taskName,
      description: widget.task.description,
      completed: true,
      completedby: widget.user.email,
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
    widget.task.completed = true;
    widget.task.completedby = widget.user.email;
    widget.task.valid = false;
    Navigator.pop(context, widget.task);
  }
}
