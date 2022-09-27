import 'package:flutter/material.dart';
//import 'package:gamified_task_tracker/task.dart'; unused rn
import 'package:gamified_task_tracker/books.dart';
import 'package:http/http.dart' as http;
//import 'package:http/http.dart'; unused, might need later

import '../RemoteAccess.dart';
import '../authors.dart';
import 'Task_detail_page.dart';

class DataFromAPI extends StatefulWidget {
  const DataFromAPI({super.key});

  @override
  _DataFromAPIState createState() => _DataFromAPIState();
}

class _DataFromAPIState extends State<DataFromAPI> {
  //List<Tasks>? tasks;
  List<Books>? books;
  List<Authors>? authors;
  var isLoaded = false;

  void _postAuthor() async {
    //var book = Books(name: "Harry Jenkin's Book about stuff and things", author: 2);
    var author = Authors(name: "Dr. Seuss");
    var response =
        await RemoteAccess().post("/authors", author).catchError((err) {});
    if (response == null) {
      return;
    }
    debugPrint("Successful");
  }

  void _putAuthor() async {
    var id = 8;
    var author = Authors(id: id, name: "Stephen King");
    var response =
        await RemoteAccess().put("/authors/$id", author).catchError((err) {});
    if (response == null) {
      return;
    }
    debugPrint("Successful");
  }

  void _removeAuthor() async {
    //var id = 7; id test for specific deletion
    var response = await RemoteAccess()
        .delete("/authors?name=Dr. Seuss")
        .catchError((err) {});
    if (response == null) {
      return;
    }
    debugPrint("Successful");
  }

  void _retrieveAuthors() async {
    authors = await RemoteAccess().getAuthors("/authors");
    if (authors != null) {
      isLoaded = true;
    }
  }

  void _retrieveBooks() async {
    books = await RemoteAccess().getBooks("/books");
    if (books != null) {
      isLoaded = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _retrieveBooks();
    _retrieveAuthors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tasks'),
          actions: <Widget>[
            IconButton(
                onPressed: _postAuthor, icon: const Icon(Icons.add_card)),
            IconButton(
                onPressed: _putAuthor,
                icon: const Icon(Icons.create_new_folder)),
            IconButton(
                onPressed: _removeAuthor, icon: const Icon(Icons.delete)),
          ],
        ),
        body: Visibility(
          visible: isLoaded,
          child: ListView.builder(
            itemCount: authors?.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(authors![index].name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TaskDetailPage(authors![index]))
                    );
              });
            },
          ),
        ));
  }
}

class User {
  final String name, email, userName;
  User(this.name, this.email, this.userName);
}
