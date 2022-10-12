import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamified_task_tracker/Pages/create_a_task_page.dart';
import 'package:gamified_task_tracker/Pages/tasks_page.dart';
import 'package:gamified_task_tracker/Pages/view_user_page.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Models/teams.dart';

import '../Models/users.dart';
import '../Views/RemoteAccess.dart';
import '../Views/auth.dart';
import '../Views/style.dart';
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
        style: TextButton.styleFrom(
          backgroundColor: primaryColor,
        ),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateATaskPage(currentUser!))),
        child: Text('Make New Task', style: GoogleFonts.getFont('Poppins')));
  }

  Future openTasks() async {
    return TasksPage(currentUser!);
  }

  void routeToLeaderBoard(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LeaderboardPage(currentUser!)));
  }

  Future<dynamic> _deleteTeam(context) async {
    var user = Users(
      id: currentUser?.id,
      team: null,
      userName: currentUser?.userName,
      firstName: currentUser?.firstName,
      lastName: currentUser?.lastName,
      password: currentUser?.password,
      email: currentUser?.email,
      points: currentUser?.points,
      admin: false,
    );
    var response = await access.delete("/teamid?team_id=${currentUser!.team}");
    if (response == null) {
      response = await access
          .put("/user?username=${currentUser!.userName}", user)
          .catchError((err) {});
      return;
    }
    debugPrint("Successful deletion");
    response = await access
        .put("/user?username=${currentUser!.userName}", user)
        .catchError((err) {});
    if (response == null) {
      print("null");
      return;
    }
    debugPrint("Successful admin update");
    currentUser?.admin = false;
    userAdmin = false;
  }

  Widget _createTeam(BuildContext context) {
    return Visibility(
        visible: !userAdmin,
        child: ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: primaryColor,
            ),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateTeam(currentUser!))),
            child:
                Text('Create a Team', style: GoogleFonts.getFont('Poppins'))));
  }

  Widget _deleteTeamButton(BuildContext context) {
    return Visibility(
        visible: userAdmin,
        child: ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: primaryColor,
            ),
            onPressed: () => openDeleteAlert(context),
            child: Text("Delete Team", style: GoogleFonts.getFont('Poppins'))));
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
        style: TextButton.styleFrom(
          backgroundColor: primaryColor,
        ),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => CreateTeam(currentUser!))),
        child: Text('Get Team Tasks', style: GoogleFonts.getFont('Poppins')));
  }

  Widget _adminOnlyTasks(BuildContext context) {
    return ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: primaryColor,
        ),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdminOnlyTasksPage(currentUser!))),
        child: Text('Only For Admin', style: GoogleFonts.getFont('Poppins')));
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _openTasks(BuildContext context) {
    return ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: primaryColor,
        ),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => TasksPage(currentUser!))),
        child: Text('Open Tasks', style: GoogleFonts.getFont('Poppins')));
  }

  Widget _joinTeam(BuildContext context) {
    return Visibility(
        visible: !userAdmin,
        child: ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: primaryColor,
            ),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => JoinTeamPage(currentUser!))),
            child: Text('Join a Team', style: GoogleFonts.getFont('Poppins'))));
  }

  Widget _signOutButton() {
    return ElevatedButton(
      style: TextButton.styleFrom(
        backgroundColor: primaryColor,
      ),
      onPressed: signOut,
      child: Text('Sign Out', style: GoogleFonts.getFont('Poppins')),
    );
  }

  Widget _refresh() {
    return SizedBox(
        width: 200,
        height: 40,
        child: ElevatedButton(
          onPressed: () async => {
            retrieveUser()
                .then((model) => {setState(() => model = currentUser)})
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Refresh Screen", style: GoogleFonts.getFont('Poppins')),
              SizedBox(width: 5),
              Icon(Icons.refresh),
            ],
          ),
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
          ),
        ));
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
          title: Text(
            "Task Tracker $firstname",
            style: GoogleFonts.getFont(
              'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 30,
            ),
          ),
          automaticallyImplyLeading: true,
          elevation: 4,
          centerTitle: true,
          leading: GestureDetector(
              child: const Icon(
                Icons.arrow_back,
                color: textColorAgainstPrimary,
              ),
              onTap: signOut),
          actions: [
            GestureDetector(
              child: const Icon(
                Icons.person,
                color: textColorAgainstPrimary,
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserPage(currentUser!))),
            ),
          ],
          backgroundColor: primaryColor,
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
                          Image.asset(
                            'assets/images/TaskBird.png',
                            width: 200,
                            height: 200,
                          ),
                          _userUid(),
                          _signOutButton(),
                          _openTasks(context),
                          _joinTeam(context),
                          _createTeam(context),
                          _viewLeaderboard(),
                          _viewUserProfile(),
                          _createTask(context),
                          _adminOnlyTasks(context),
                          _deleteTeamButton(context),
                          _refresh(),
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
                  Image.asset(
                    'assets/images/TaskBird.png',
                    width: 200,
                    height: 200,
                  ),
                  _signOutButton(),
                  _refresh(),
                  const RefreshProgressIndicator()
                ]),
              ));
  }

  _viewLeaderboard() {
    return Visibility(
        visible: true,
        child: ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: primaryColor,
            ),
            onPressed: () => routeToLeaderBoard(context),
            child: Text('Leaderboard', style: GoogleFonts.getFont('Poppins'))));
  }

  _viewUserProfile() {
    return Visibility(
        visible: userNull,
        child: ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: primaryColor,
            ),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserPage(userData![0]))),
            child:
                Text('User profile', style: GoogleFonts.getFont('Poppins'))));
  }
}
