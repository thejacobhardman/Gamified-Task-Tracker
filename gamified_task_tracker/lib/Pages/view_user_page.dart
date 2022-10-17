import '../Models/users.dart';
import 'package:flutter/material.dart';

import '../Views/RemoteAccess.dart';
import '../Views/style.dart';

import '../widgets/ttscaffold.dart';
import '../widgets/ttform.dart';

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

  @override
  void initState() {
    super.initState();
    retrieveTeamCode().then((model) => {setState(() => model = teamData)});
  }

  Widget build(BuildContext context) {

    return TTScaffold(
      title: 'Profile Page - ${widget.user.userName!}',
      body: TTForm(
        children: [

          const TTText(
            'First Name', 
            thickness: FontWeight.w800,
            size: 20,
            ),
          TTText(widget.user.firstName!),

          TTFormElement(child:Container()),

          const TTText(
            'Last Name', 
            thickness: FontWeight.w800,
            size: 20,
            ),
          TTText(widget.user.lastName!),

          TTFormElement(child:Container()),

          const TTText(
            'Username', 
            thickness: FontWeight.w800,
            size: 20,
            ),
          TTText(widget.user.userName!),

          TTFormElement(child:Container()),

          const TTText(
            'Email', 
            thickness: FontWeight.w800,
            size: 20,
            ),
          TTText(widget.user.email!),

          TTFormElement(child:Container()),

          const TTText(
            'Points', 
            thickness: FontWeight.w800,
            size: 20,
            ),
          TTText(widget.user.points!.toString()),

          TTFormElement(child:Container()),

          const TTText(
            'Team Code', 
            thickness: FontWeight.w800,
            size: 20,
            ),
          teamData != null ? 
            TTText(teamData[0].teamCode) : 
            const TTText('-'),

        ],
        )

    );
  }
}
