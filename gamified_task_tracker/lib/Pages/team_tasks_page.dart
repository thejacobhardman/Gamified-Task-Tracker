import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Data/menu_item.dart';
import '../Model/menu_item.dart';
import '../Model/team_model.dart';
import '../auth.dart';

class TeamTasks extends StatefulWidget {
  const TeamTasks({super.key});

  @override
  State<TeamTasks> createState() => _TeamTasksState();
}

class _TeamTasksState extends State<TeamTasks> {
  final User? user = Auth().currentUser;
  final controllerName = TextEditingController();

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Team Tasks'),
          actions: [
            PopupMenuButton<MenuItemT>(
                onSelected: (item) => onSelected(context, item),
                itemBuilder: (context) => [
                      ...MenuItems.itemsMain.map(buildItem).toList(),
                    ]),
          ],
        ),
      );

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
