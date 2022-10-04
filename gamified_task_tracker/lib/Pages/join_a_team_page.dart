import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gamified_task_tracker/RemoteAccess.dart';

import '../Models/teams.dart';
import '../Models/users.dart';

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
    _retrieveTeams().then((model) => {setState(() => model = teamList)});
  }

  Widget _entryField(
      String title,
      TextEditingController controller,
      ) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
        ));
  }



  Future _retrieveTeams() async {
    teamList = await access.getTeams("/teams");
    if (teamList != null) {
    }
    return teamList;
  }

  Future _checkTeam() async {
    for (int x = 0; x < teamList!.length; x++) {
      if (_controllerTeamCODE.text == teamList![x]?.teamCode) {
        _changeTeam(_controllerTeamCODE.text);
      } else {
        showErrorSnackBar();
      }
    }
  }

  Future _changeTeam(String teamid) async {
    var id = widget.user.id;
    int teamID = int.parse(teamid);
    var teamChange = Users(
        userName: widget.user.userName,
        firstName: widget.user.firstName,
        lastName: widget.user.lastName,
        email: widget.user.email,
        points: widget.user.points,
        team: teamID);
    var response =
    await access.put("/user/$id", teamChange).catchError((err) {});
    if (response == null) {
      return;
    }
    debugPrint("Successful");
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
      _checkTeam,
      child: Text("Join Team"),
    );
  }
  
  void showErrorSnackBar() {
    const snackbar = SnackBar(content :
    Text("No Team with that ID exists"));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Join a New Team"),
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _entryField('Enter a team CODE', _controllerTeamCODE),
                //_errorMessage(),
                _submitButton(),
              ],
            )
        )
    );
  }
}
