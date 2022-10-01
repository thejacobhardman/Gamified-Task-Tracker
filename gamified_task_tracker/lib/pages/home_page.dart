import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamified_task_tracker/pages/tasks_page.dart';

import '../auth.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Future openTasks() async {
    return DataFromAPI();
  }

  Widget _title() {
    return const Text('Gamified Task Tracker');
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _openTasks() {
    return ElevatedButton(
        onPressed: openTasks, child: const Text('Open Tasks'));
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _title(),
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _userUid(),
                _signOutButton(),
                _openTasks(),
              ],
            )));
  }
}
