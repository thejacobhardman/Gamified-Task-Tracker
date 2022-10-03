import 'package:flutter/material.dart';

import '../Models/authors.dart';

class TaskDetailPage extends StatelessWidget {
  final Authors author;
  const TaskDetailPage(this.author, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(author.name),
      ),
      body: Center(
        child: Text(author.id.toString()),
      ),
    );
  }
}

