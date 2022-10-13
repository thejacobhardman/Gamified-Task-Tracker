import 'package:flutter/material.dart';
//import 'package:gamified_task_tracker/task.dart'; unused rn
import 'package:http/http.dart' as http;
//import 'package:http/http.dart'; unused, might need later

import '../Views/RemoteAccess.dart';
import '../Views/auth.dart';
import '../Views/style.dart';

import '../widgets/ttform.dart';
import '../widgets/ttscaffold.dart';
import 'Task_detail_page.dart';
import 'create_a_task_page.dart';


import '../Models/teamTasks.dart';
import '../Models/users.dart';

class TasksPage extends StatefulWidget {
  /*DataFromAPI({Key? key}) : super(key: key);*/
  TasksPage(this.user, {super.key});
  final Users user;

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  List<TeamTasks>? tasksOnTeam;
  RemoteAccess access = RemoteAccess();
  var isLoaded = false;

  Future<void> signOut() async {
    await Auth().signOut();
  }
  
  updateTask(int index) async {
    tasksOnTeam![index] = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TaskDetailPage(
                tasksOnTeam![index], widget.user)));
    setState(() {
      isLoaded = false;
      _retrieveTasksOnTeam()
          .then((model) => {setState(() => model = tasksOnTeam)});
      isLoaded = true;
    });
  }

  Future _retrieveTasksOnTeam() async {
    tasksOnTeam = await access.getTeamTasks(widget.user.team);
    if (tasksOnTeam != null) {
      var index = 0;
      while (index < tasksOnTeam!.length) {
        if (tasksOnTeam![index].completed == true) {
          tasksOnTeam!.removeAt(index);
        } else {
          index++;
        }
      }
      print("successful");
      isLoaded = true;
      /*tasksOnTeam!.sort((a, b) => b.points.compareTo(a.points));*/
    }
    return tasksOnTeam;
  }

  @override
  void initState() {
    super.initState();
    _retrieveTasksOnTeam()
        .then((model) => {setState(() => model = tasksOnTeam)});
  }

  @override
  Widget build(BuildContext context) {
    return TTLoadListScaffold(
      title: 'Tasks',
      isLoaded: isLoaded,
      list: tasksOnTeam,
      itemBuilder: (context, index) {
        return ListTile(
          title: TTText("Task: ${tasksOnTeam![index].taskName}"),
          subtitle: TTText(
            "Description: ${tasksOnTeam![index].description}"),
          onTap: () {
            updateTask(index);
          });
      },
      onRefresh: () async {
        _retrieveTasksOnTeam()
          .then((model) => {setState(() => model = tasksOnTeam)});
      }
    );
  }
}
