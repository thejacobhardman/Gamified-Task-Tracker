import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/task.dart';
import '../Models/teams.dart';
import '../Views/RemoteAccess.dart';
import '../Views/auth.dart';
import '../Views/style.dart';
import 'Task_detail_page.dart';
import 'completed_task_detail_page.dart';
import 'create_a_task_page.dart';

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

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Future _retrieveTasksOnTeam() async {
    tasksOnTeam = await access.getTeamTasks(widget.user.team);
    if (tasksOnTeam != null) {
      var index = 0;
      while (index < tasksOnTeam!.length) {
        if (tasksOnTeam![index].completed == false ||
            tasksOnTeam![index].valid == true) {
          tasksOnTeam!.removeAt(index);
        } else {
          index++;
        }
      }
      print("successful");
      isLoaded = true;
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
          backgroundColor: primaryColor,
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
