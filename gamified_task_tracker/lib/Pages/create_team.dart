import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Model/team_model.dart';
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
              final team = Team(
                  name: controllerName.text,
                  members: [user?.email ?? 'failt'],
                  admin: user?.email ?? 'failt',
                  tasks: []);
              final player =
                  Player(id: user?.email ?? 'failt', teams: [], points: 0);
              createTeam(team, player);
              Navigator.pop(context);
            })
      ]));

  InputDecoration decoration(String label) => InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      );

  Future createTeam(Team team, Player player) async {
    final docTeam = FirebaseFirestore.instance.collection('teams').doc();

    final docPlayer = FirebaseFirestore.instance
        .collection('players')
        .doc(user?.email ?? 'failt');

    team.id = docTeam.id;
    team.members.add(player.id);
    player.teams.add(team.id);

    final json_player = player.toJson();
    await docPlayer.set(json_player);

    final json_team = team.toJson();
    await docTeam.set(json_team);
  }
}
