import 'package:flutter/material.dart';

import '../Models/teamUsers.dart';
import '../Models/users.dart';
import '../Views/RemoteAccess.dart';
import '../Views/auth.dart';
import '../Views/style.dart';
import '../widgets/ttform.dart';
import '../widgets/ttscaffold.dart';

class LeaderboardPage extends StatefulWidget {
  LeaderboardPage(this.user, {super.key});
  final Users user;

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<TeamUsers>? usersOnTeam;
  var isLoaded = false;
  RemoteAccess access = RemoteAccess();

  @override
  void initState() {
    super.initState();
    _retrieveUsersOnTeam().then((model) => {setState(() => model = usersOnTeam)});
  }

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Future _retrieveUsersOnTeam() async {
    usersOnTeam = await access.getTeamUsers(widget.user.team);
    if (usersOnTeam != null) {
      print("successful");
      isLoaded = true;
      usersOnTeam!.sort((a,b) => b.points.compareTo(a.points));
    }
    return usersOnTeam;
  }

  @override
  Widget build(BuildContext context) {
    return TTLoadListScaffold(
      title: 'Points Leaderboard',
      isLoaded: isLoaded,
      list: usersOnTeam,
      itemBuilder: (context, index) {
        return ListTile(
            title: TTText(usersOnTeam![index].userName),
            subtitle: TTText("Task Points: ${usersOnTeam![index].points}"),
            );
      },
      onRefresh: () async {
        _retrieveUsersOnTeam()
          .then((model) => {setState(() => model = usersOnTeam)});
      }
    );
  }
}

