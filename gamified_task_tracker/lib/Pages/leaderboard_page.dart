import 'package:flutter/material.dart';
import 'package:gamified_task_tracker/RemoteAccess.dart';

import '../Models/teamUsers.dart';
import '../Models/users.dart';
import '../auth.dart';

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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tasks'),
          actions: <Widget>[
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back)),
            IconButton(onPressed: signOut, icon: const Text('Sign Out')),
          ],
        ),
        body: isLoaded
            ? RefreshIndicator(
            child: Visibility(
              visible: isLoaded,
              child: ListView.builder(
                itemCount: usersOnTeam?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(usersOnTeam![index].userName),
                      subtitle: Text("Task Points: ${usersOnTeam![index].points}"),
                      );
                },
              ),
            ),
            onRefresh: () async {
             _retrieveUsersOnTeam()
                 .then((model) => {setState(() => model = usersOnTeam)});
            })
            : Center(
          child: CircularProgressIndicator(),
        ));
  }
}

