import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamified_task_tracker/pages/tasks_page.dart';

import '../Models/teams.dart';
import '../Models/users.dart';
import '../RemoteAccess.dart';
import '../auth.dart';
import 'create_a_team_page.dart';
import 'join_a_team_page.dart';
import 'leaderboard_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HopePageState createState() => _HopePageState();
}

class _HopePageState extends State<HomePage> {
  late final User? user;
  var userData;
  RemoteAccess access = RemoteAccess();
  String firstname = "";
  String lastname = "";

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Future createTeam() async {
    String name = "";
  }

  _putUserTest() async {
    String name = "demoman2";
    var user = Users(
        id: 2,
        userName: "demoman2",
        email: "idk@test.test",
        password: "SUPERPASSWORD",
        firstName: "Demo",
        lastName: "Man2",
        points: 750,
        team: 1);
    var response =
        await access.put("/user?username=$name", user).catchError((err) {});
    if (response == null) {
      debugPrint("Not Successful");
      return;
    }
    debugPrint("Successful");
  }

  Future retrieveUser() async {
    user = Auth().currentUser;
    print("working");
    userData = await access.getUsers(user?.email);
    firstname = userData![0].firstName;
    lastname = userData![0].lastName;
    print(firstname);
    return userData;
  }

  Future openTasks() async {
    return DataFromAPI();
  }

  Future _testFunc() async {
    var test = await access.getUsers(user?.email);
  }

  Widget _testButton() {
    return ElevatedButton(
        onPressed: () {
          _testFunc();
        },
        child: const Text('See users'));
  }

  Widget _createTeam(BuildContext context) {
    return ElevatedButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => CreateTeam())),
        child: const Text('Create a Team'));
  }

  Widget _getTeamTasks(BuildContext context) {
    return ElevatedButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => CreateTeam())),
        child: const Text('Get Team Tasks'));
  }

  Widget _title() {
    return Text('Task Tracker: ' + firstname);
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _openTasks(BuildContext context) {
    return ElevatedButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => DataFromAPI())),
        child: const Text('Open Tasks'));
  }

  Widget _joinTeam(BuildContext context) {
    return ElevatedButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => JoinTeamPage(userData![0]))),
        child: const Text('Join a Team'));
  }

  _testUserChange() {
    return ElevatedButton(onPressed: retrieveUser, child: const Text("test"));
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
    );
  }

  @override
  void initState() {
    super.initState();
    retrieveUser().then((model) => {setState(() => model = userData)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _title(),
        ),
        body: Container(
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
                _testButton()
                //_joinTeam(),
                //_makeTeam(),
              ],
            )));
  }

  _viewLeaderboard() {
    return ElevatedButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LeaderboardPage(userData![0]))),
        child: const Text('Leaderboard'));
  }
}
