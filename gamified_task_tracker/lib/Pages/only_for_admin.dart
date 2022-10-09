import 'package:flutter/material.dart';
//import 'package:gamified_task_tracker/task.dart'; unused rn
import 'package:http/http.dart' as http;
//import 'package:http/http.dart'; unused, might need later

import '../Models/task.dart';
import '../Models/teams.dart';
import 'Task_detail_page.dart';
import 'completed_task_detail_page.dart';
import 'create_a_task_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';

import 'package:gamified_task_tracker/RemoteAccess.dart';
import '../Models/teamTasks.dart';
import '../Models/users.dart';

class AdminOnlyTasksPage extends StatefulWidget {
  /*DataFromAPI({Key? key}) : super(key: key);*/
  AdminOnlyTasksPage(this.user, {super.key});
  final Users user;

  @override
  State<AdminOnlyTasksPage> createState() => _AdminOnlyTasksPage();
}

class _AdminOnlyTasksPage extends State<AdminOnlyTasksPage> {
  List<TeamTasks>? tasksOnTeam;
  RemoteAccess access = RemoteAccess();
  var isLoaded = false;
  List<TeamTasks> emptyList = [];

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Future _retrieveTasksOnTeam() async {
    tasksOnTeam = await access.getTeamTasks(widget.user.team);
    if (tasksOnTeam != null) {
      var index = 0;
      for (var t = 0; t <= tasksOnTeam!.length; t++) {
        if (tasksOnTeam![index].completed == false) {
          tasksOnTeam?.removeAt(index);
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Marked Completed'),
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
                                        CompletedTaskDetailPage(
                                            tasksOnTeam![index], widget.user)));
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
