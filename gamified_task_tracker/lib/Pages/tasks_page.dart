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
  //List<Tasks>? tasks;
  List<TeamTasks>? tasksOnTeam;
  RemoteAccess access = RemoteAccess();
  var isLoaded = false;

  /*void _postAuthor() async {
    //var book = Books(name: "Harry Jenkin's Book about stuff and things", author: 2);
    var author = Authors(name: "Jameson Franklin");
    var response = await access.post("/authors", author).catchError((err) {});
    if (response == null) {
      return;
    }
    debugPrint("Successful");
  }

  void _putAuthor() async {
    var id = 8;
    var author = Authors(id: id, name: "Stephen King");
    var response =
        await access.put("/authors/$id", author).catchError((err) {});
    if (response == null) {
      return;
    }
    debugPrint("Successful");
  }

  void _removeAuthor() async {
    //var id = 7; id test for specific deletion
    var response = await access
        .delete("/authors?name=Jameson Franklin")
        .catchError((err) {});
    if (response == null) {
      return;
    }
    debugPrint("Successful");
  }*/

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
            //IconButton(
            /*onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateATaskPage(context))),
            //icon: const Icon(Icons.add_card)),
            IconButton(
                onPressed: _putAuthor,
                icon: const Icon(Icons.create_new_folder)),
            IconButton(
                onPressed: _removeAuthor, icon: const Icon(Icons.delete)),
            IconButton(
                onPressed: _removeAuthor, icon: const Icon(Icons.delete)),
            IconButton(onPressed: signOut, icon: const Text('Sign Out')),*/
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
                                        TaskDetailPage(tasksOnTeam![index])));
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
