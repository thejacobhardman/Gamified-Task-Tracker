import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Models/teams.dart';
import '../RemoteAccess.dart';
import '../auth.dart';

class CreateTeam extends StatefulWidget {
  const CreateTeam({super.key});

  @override
  State<CreateTeam> createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  final User? user = Auth().currentUser;
  final controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Create Team'),
      ),
      body: ListView(padding: EdgeInsets.all(16), children: <Widget>[
        TextField(
            controller: controllerName, decoration: decoration('Team Name')),
        const SizedBox(height: 32),
        ElevatedButton(
            child: Text('Create'),
            onPressed: () {
              final teams =
                  Teams(teamName: controllerName.text, teamCode: "A12345");
              createTeam(teams);
              Navigator.pop(context);
            })
      ]));

  InputDecoration decoration(String label) => InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      );

  Future createTeam(Teams teams) async {
    var response =
        await RemoteAccess().post('/team', teams).catchError((err) {});
    if (response == null) return;
    print("Successfully created team");
  }
}
