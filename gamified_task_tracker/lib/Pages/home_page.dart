import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamified_task_tracker/Pages/create_a_task_page.dart';
import 'package:gamified_task_tracker/Pages/tasks_page.dart';
import 'package:gamified_task_tracker/Pages/view_user_page.dart';

import '../Models/teams.dart';
import '../Models/users.dart';
import '../RemoteAccess.dart';
import '../auth.dart';
import 'create_a_team_page.dart';
import 'join_a_team_page.dart';
import 'leaderboard_page.dart';
import 'only_for_admin.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HopePageState createState() => _HopePageState();
}

class _HopePageState extends State<HomePage> {
  User? user;
  var userData;
  Users? currentUser;
  RemoteAccess access = RemoteAccess();
  String firstname = "";
  String lastname = "";
  bool userAdmin = false;
  bool userNull = false;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Future createTeam() async {
    String name = "";
  }

  Future retrieveUser() async {
    user = Auth().currentUser;
    userData = await access.getUsers(user?.email);
    if (userData!.length == 0) {
      print("NULL user");
      userNull = true;
      return;
    }
    currentUser = userData![0];
    if (currentUser?.admin != null) {
      userAdmin = currentUser!.admin!;
    }
    return currentUser;
  }

  Widget _createTask(BuildContext context) {
    return ElevatedButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateATaskPage(currentUser!))),
        child: const Text('Make New Task'));
  }

  Future openTasks() async {
    return TasksPage(currentUser!);
  }

  void routeToLeaderBoard(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LeaderboardPage(currentUser!)));
  }

  Future<dynamic> _deleteTeam(context) async {
    var response = await access.delete("/teamid?team_id=${currentUser!.team}");
    if (response == null) {
      print("null");
      return;
    }
    debugPrint("Successful deletion");
  }

  Widget _createTeam(BuildContext context) {
    return Visibility(
        visible: !userAdmin,
        child: ElevatedButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateTeam(currentUser!))),
            child: const Text('Create a Team')));
  }

  Widget _deleteTeamButton(BuildContext context) {
    return Visibility(
        visible: userAdmin,
        child: ElevatedButton(
            onPressed: () => openDeleteAlert(context),
            child: Text("Delete Team")));
  }

  openDeleteAlert(BuildContext context) {
    Widget confirmButton = TextButton(
      child: Text("Confirm"),
      onPressed: () async => {
        _deleteTeam(context),
        Navigator.of(context).pop(),
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () => {Navigator.of(context).pop()},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert!"),
      content:
          Text("This will delete your team. NOTE: This action is irreversable"),
      actions: [
        confirmButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _getTeamTasks(BuildContext context) {
    return ElevatedButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => CreateTeam(currentUser!))),
        child: const Text('Get Team Tasks'));
  }

  Widget _adminOnlyTasks(BuildContext context) {
    return ElevatedButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdminOnlyTasksPage(currentUser!))),
        child: const Text('Only For Admin'));
  }

  Widget _title() {
    return Text('Task Tracker: ' + firstname);
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _openTasks(BuildContext context) {
    return ElevatedButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => TasksPage(currentUser!))),
        child: const Text('Open Tasks'));
  }

  Widget _joinTeam(BuildContext context) {
    return Visibility(
        visible: !userAdmin,
        child: ElevatedButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => JoinTeamPage(currentUser!))),
            child: const Text('Join a Team')));
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
    );
  }

  Widget _refresh() {
    return ElevatedButton(
      onPressed: () async {
        retrieveUser().then((model) => {setState(() => model = currentUser)});
      },
      child: const Text('Refresh screen'),
    );
  }

  @override
  void initState() {
    super.initState();
    retrieveUser().then((model) => {setState(() => model = currentUser)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _title(),
        ),
        body: !userNull
            ? RefreshIndicator(
                child: Visibility(
                  visible: !userNull,
                  child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _userUid(),
                          _signOutButton(),
                          _openTasks(context),
                          _joinTeam(context),
                          _createTeam(context),
                          _viewLeaderboard(),
                          _refresh(),
                          _viewUserProfile(),
                          _createTask(context),
                          _adminOnlyTasks(context),
                          _deleteTeamButton(context),
                          //_makeTeam(),
                        ],
                      )),
                ),
                onRefresh: () async {
                  retrieveUser()
                      .then((model) => {setState(() => model = currentUser)});
                })
            : Center(
                child: Column(children: <Widget>[
                  _signOutButton(),
                  const RefreshProgressIndicator()
                ]),
              ));
  }

  _viewLeaderboard() {
    return Visibility(
        visible: true,
        child: ElevatedButton(
            onPressed: () => routeToLeaderBoard(context),
            child: const Text('Leaderboard')));
  }

  _viewUserProfile() {
    return Visibility(
        visible: userNull,
        child: ElevatedButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserPage(userData![0]))),
            child: const Text('User profile')));
  }
}
