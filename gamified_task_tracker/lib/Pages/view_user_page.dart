import '../Models/users.dart';
import 'package:flutter/material.dart';

import '../RemoteAccess.dart';

class UserPage extends StatefulWidget {
  const UserPage(this.user, {super.key});
  final Users user;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void setUserValues() {}

  var teamData;
  RemoteAccess access = RemoteAccess();

  Future retrieveTeamCode() async {
    teamData = await access.getTeamsById(widget.user.team);
    return teamData;
  }

  Widget _teamCode() {
    if (teamData != null) {
      return Text('Team Code: ' + teamData[0].teamCode);
    } else {
      return Text('Team Code: No Code');
    }
  }

  @override
  void initState() {
    super.initState();
    retrieveTeamCode().then((model) => {setState(() => model = teamData)});
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text('Profile Page - ${widget.user.userName!}' ?? "Profile Page"),
          actions: <Widget>[
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back)),
            //IconButton(onPressed: signOut, icon: const Text('Sign Out')),
          ],
        ),
        body: Column(
          children: [
            Text(widget.user.firstName! ?? "no first name"),
            Text(widget.user.lastName! ?? "no last name"),
            Text(widget.user.email! ?? "no email"),
            Text(
                widget.user.points!.toString() ?? "no points - do some tasks!"),
            _teamCode()
          ],
        ));
  }
}
