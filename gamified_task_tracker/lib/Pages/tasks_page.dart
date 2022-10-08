import 'package:flutter/material.dart';
//import 'package:gamified_task_tracker/task.dart'; unused rn
import 'package:http/http.dart' as http;
//import 'package:http/http.dart'; unused, might need later

import '../Models/books.dart';
import '../RemoteAccess.dart';
import '../Models/authors.dart';
import 'Task_detail_page.dart';
import 'create_a_task_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';

class DataFromAPI extends StatefulWidget {
  DataFromAPI({Key? key}) : super(key: key);

  @override
  _DataFromAPIState createState() => _DataFromAPIState();
}

class _DataFromAPIState extends State<DataFromAPI> {
  //List<Tasks>? tasks;
  List<Authors>? authors;
  RemoteAccess access = RemoteAccess();
  var isLoaded = false;

  void _postAuthor() async {
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
  }

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tasks'),
          actions: <Widget>[
            //IconButton(
                /*onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateATaskPage(context))),*/
                //icon: const Icon(Icons.add_card)),
            IconButton(
                onPressed: _putAuthor,
                icon: const Icon(Icons.create_new_folder)),
            IconButton(
                onPressed: _removeAuthor, icon: const Icon(Icons.delete)),
            IconButton(
                onPressed: _removeAuthor, icon: const Icon(Icons.delete)),
            IconButton(onPressed: signOut, icon: const Text('Sign Out')),
          ],
        ),
        body: isLoaded
            ? RefreshIndicator(
                child: Visibility(
                  visible: isLoaded,
                  child: ListView.builder(
                    itemCount: authors?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text(authors![index].name),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TaskDetailPage(authors![index])));
                          });
                    },
                  ),
                ),
                onRefresh: () async {
                })
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}