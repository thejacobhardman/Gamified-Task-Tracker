import 'package:flutter/material.dart';
//import 'package:gamified_task_tracker/task.dart'; unused rn
import 'package:http/http.dart' as http;
//import 'package:http/http.dart'; unused, might need later

import 'Task_detail_page.dart';
import 'create_a_task_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';

import 'package:gamified_task_tracker/RemoteAccess.dart';
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

  Future _retrieveTasksOnTeam() async {
    tasksOnTeam = await access.getTeamTasks(widget.user.team);
    if (tasksOnTeam != null) {
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tasks'),
          actions: <Widget>[
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back)),
            IconButton(onPressed: signOut, icon: const Text('Sign Out')),
          ],
        ),
        body: isLoaded
            ? RefreshIndicator(
                child: Visibility(
                  visible: isLoaded,
                  child: ListView.builder(
                    itemCount: tasksOnTeam?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text("Task: ${tasksOnTeam![index].taskName}"),
                          subtitle: Text(
                              "Description: ${tasksOnTeam![index].description}"),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TaskDetailPage(tasksOnTeam![index], widget.user)));
                          });
                    },
                  ),
                ),
                onRefresh: () async {
                  _retrieveTasksOnTeam()
                      .then((model) => {setState(() => model = tasksOnTeam)});
                })
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
