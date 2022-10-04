import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamified_task_tracker/Model/menu_item.dart';
import 'package:gamified_task_tracker/Pages/team_tasks_page.dart';

import '../Data/menu_item.dart';
import '../auth.dart';
import 'create_team.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;
  final CollectionReference _team =
      FirebaseFirestore.instance.collection('teams');

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _userUid(),
          actions: [
            PopupMenuButton<MenuItemT>(
                onSelected: (item) => onSelected(context, item),
                itemBuilder: (context) => [
                      ...MenuItems.itemsMain.map(buildItem).toList(),
                    ]),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CreateTeam()));
            }),
        body: StreamBuilder(
            stream: _team.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TeamTasks()));
                              },
                              title: Text(documentSnapshot['name']),
                              subtitle: Text(documentSnapshot['id'])));
                    });
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }

  PopupMenuItem<MenuItemT> buildItem(MenuItemT item) => PopupMenuItem(
        value: item,
        child: Text(item.text),
      );

  onSelected(BuildContext context, MenuItemT item) {
    switch (item) {
      case MenuItems.itemSignOut:
        signOut();
    }
  }
}
