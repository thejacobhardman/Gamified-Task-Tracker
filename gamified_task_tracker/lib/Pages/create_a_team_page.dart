import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Models/teams.dart';
import '../Models/users.dart';
import '../RemoteAccess.dart';
import '../auth.dart';

class CreateTeam extends StatefulWidget {
  const CreateTeam(this.user, {super.key});
  final Users user;

  @override
  State<CreateTeam> createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  List<Teams>? newTeam;
  final controllerName = TextEditingController();
  String code = "";

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
              var teams =
                  Teams(teamName: controllerName.text, teamCode: code);
              print("sent name ${teams.teamName}");
              print(" sent code ${teams.teamCode}");
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
    updateTeam();
  }

  generateTeamCode() {
    final String alphanumeric = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    for (int x = 0; x < 6; x++) {
      code += alphanumeric[Random().nextInt(alphanumeric.length)];
    }
  }

  Future<dynamic> updateTeam() async {
    print("update code $code");
    newTeam = await RemoteAccess().getTeams(code).catchError((err) {});
    print("team list instance ${newTeam}");
    print("team check ${newTeam?.length}");
    if (newTeam != null) {
      print("successful team GET");
      int? id = newTeam![0].id;
      var name = widget.user.userName;
      var teamChange = Users(
          userName: name,
          firstName: widget.user.firstName,
          lastName: widget.user.lastName,
          email: widget.user.email,
          points: widget.user.points,
          team: id,
          admin: true,
          );
      var response = await RemoteAccess().put("/user?username=$name", teamChange);
      if (response == null) {
        print("null");
        return;
      }
      debugPrint("Successful update");
      widget.user.team = id;
      widget.user.admin = true;
    }
  }

  @override
  void initState() {
    generateTeamCode();
    print("code generated $code");
    super.initState();
  }
}
