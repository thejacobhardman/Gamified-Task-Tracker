import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gamified_task_tracker/widgets/ttscaffold.dart';

import '../Models/teams.dart';
import '../Models/users.dart';
import '../Views/RemoteAccess.dart';
import '../widgets/ttform.dart';

class JoinTeamPage extends StatefulWidget {
  const JoinTeamPage(this.user, {super.key});
  final Users user;

  @override
  State<JoinTeamPage> createState() => _JoinTeamPageState();
}

class _JoinTeamPageState extends State<JoinTeamPage> {
  final TextEditingController _controllerTeamCODE = TextEditingController();
  List <Teams?>? teamList;
  RemoteAccess access = RemoteAccess();
  bool validID = false;

  @override
  void initState() {
    super.initState();
  }

  Future _retrieveTeams() async {
    teamList = await access.getTeams("/team");
    if (teamList != null) {
    } else {
      print('nullTeam');
    }
    return teamList;
  }

  Future _checkTeam() async {
    teamList = await access.getTeams(_controllerTeamCODE.text);
    if (teamList != null && _controllerTeamCODE.text == teamList![0]?.teamCode) {
      _changeTeam(teamList![0]?.id);
    } else {
      showErrorSnackBar();
    }
  }

  Future _changeTeam(int? teamid) async {
    print(teamid);
    var name = widget.user.userName;
    var teamChange = Users(
        userName: name,
        firstName: widget.user.firstName,
        lastName: widget.user.lastName,
        email: widget.user.email,
        points: widget.user.points,
        team: teamid,
        admin: widget.user.admin,
        password: widget.user.password,
        id: widget.user.id);
    var response =
    await access.put("/user?username=$name", teamChange).catchError((err) {});
    if (response == null) {
      print("null");
      return;
    }
    debugPrint("Successful");
    widget.user.team = teamid;
    Navigator.pop(context);
  }
  
  void showErrorSnackBar() {
    const snackbar = SnackBar(content :
    Text("No Team with that ID exists"));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
  
  @override
  Widget build(BuildContext context) {

    return TTScaffold(
      title: "Join a New Team", 
      body: TTForm(
          children: [

            TTTextField(
              labelText: 'Enter a team CODE',
              controller: _controllerTeamCODE,
            ),

            TTButton(
              text: 'Join Team',
              onPressed: _checkTeam
              ),

          ]
        )
      );
  }
}
