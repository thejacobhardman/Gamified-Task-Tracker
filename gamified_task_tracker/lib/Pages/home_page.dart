import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamified_task_tracker/Pages/create_a_task_page.dart';
import 'package:gamified_task_tracker/Pages/tasks_page.dart';
import 'package:gamified_task_tracker/Pages/view_user_page.dart';
import 'package:gamified_task_tracker/widgets/ttform.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Models/teams.dart';

import '../Models/users.dart';
import '../Views/RemoteAccess.dart';
import '../Views/auth.dart';
import '../Views/style.dart';
import '../widgets/ttscaffold.dart';
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
  bool isLoaded = false;
  bool onTeam = false;
  Future<void> signOut() async {
    await Auth().signOut();
  }

  updateUser() async {
    currentUser = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateTeam(currentUser!)));
    setState(() {
      userAdmin = currentUser!.admin!;
      if (currentUser!.team != null) {
        onTeam = true;
      }
    });
  }


  Future retrieveUser() async {
    user = Auth().currentUser;
    userData = await access.getUsers(user?.email);
    if (userData!.length == 0) {
      print("NULL user");
      isLoaded = false;
      return;
    }
    currentUser = userData![0];
    if (currentUser?.admin != null) {
      userAdmin = currentUser!.admin!;
    }
    if (currentUser!.team != null) {
      onTeam = true;
    }
    return currentUser;
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
    setState(() {
      userAdmin = false;
      onTeam = false;
    });
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


  @override
  void initState() {
    retrieveUser().then((model) => {setState(() => model = currentUser)});
    if (currentUser != null) {
      isLoaded = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isLoaded = true;
    return TTScaffold(
      title: 'Task Tracker',
      leading: IconButton(
          icon: const Icon(
            Icons.logout,
            color: textColorAgainstPrimary,
          ),
          onPressed: signOut
          ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.person,
            color: textColorAgainstPrimary,
          ),
          onPressed: isLoaded ? () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserPage(currentUser!))) : null,
        ),
      ],
      body:  
        RefreshIndicator (
          child: Visibility(
            visible: true,
            child: TTForm(
              children: [

                TTText(
                  currentUser?.userName != null ? "Welcome, ${currentUser?.userName}!" : "",
                  size: 20,
                  thickness: FontWeight.w600,
                  ),

                TTFormElement(
                  child: Image.asset(
                    'assets/images/TaskBird.png',
                    width: 200,
                    height: 200,
                  ),
                ),

                TTFormElement(
                  edgeInsets: const EdgeInsets.all(10),
                  child:Column()
                  ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TTButton(
                      edgeInsets: EdgeInsets.zero,
                      text: 'My Tasks',
                      width: 140,
                      height: 60,
                      onPressed: isLoaded ? () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TasksPage(currentUser!))) : null
                    ),
                    TTButton(
                      edgeInsets: EdgeInsets.zero,
                      text: 'Create Task',
                      backgroundColor: createColor,
                      width: 140,
                      height: 60,
                      onPressed: isLoaded ? () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CreateATaskPage(currentUser!))) : null
                    ),
                  ],
                  ),

                TTFormElement(
                  edgeInsets: const EdgeInsets.all(10),
                  child:Column()
                  ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                     TTButton(
                      edgeInsets: EdgeInsets.zero,
                      text: 'Join Team',
                      width: 140,
                      height: 60,
                      onPressed: isLoaded ? () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => JoinTeamPage(currentUser!))) : null
                    ),
                    TTButton(
                      edgeInsets: EdgeInsets.zero,
                      text: 'Create Team',
                      backgroundColor: createColor,
                      width: 140,
                      height: 60,
                      onPressed: isLoaded ? () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CreateTeam(currentUser!))) : null
                    ), 
                  ],
                  ),

                TTFormElement(
                  edgeInsets: const EdgeInsets.all(10),
                  child:Column()
                  ),

                TTButton(
                  edgeInsets: EdgeInsets.zero,
                  text: 'Leaderboard',
                  width: 140,
                  height: 60,
                  onPressed: isLoaded ? () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LeaderboardPage(currentUser!))) : null
                ),

                TTFormElement(
                  edgeInsets: const EdgeInsets.all(20),
                  child:Column()
                  ),

                TTButton(
                  visible: userAdmin,
                  edgeInsets: EdgeInsets.zero,
                  text: 'Completed Tasks',
                  width: 180,
                  height: 50,
                  onPressed: isLoaded ? () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminOnlyTasksPage(currentUser!))) : null
                ),

                TTFormElement(
                  visible: userAdmin,
                  edgeInsets: const EdgeInsets.all(10),
                  child:Column()
                  ),

                TTButton(
                  edgeInsets: EdgeInsets.zero,
                  text: 'Delete Team',
                  backgroundColor: dangerColor,
                  visible: userAdmin,
                  width: 180,
                  height: 50,
                  onPressed: isLoaded ? () => () => openDeleteAlert(context) : null,
                  ),

                TTFormElement(
                  visible: userAdmin,
                  edgeInsets: const EdgeInsets.all(10),
                  child:Column()
                  ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TTButton(
                      text: 'Refresh',
                      backgroundColor: secondaryColor,
                      width: 100,
                      height: 50,
                      onPressed: () async => {
                        retrieveUser()
                          .then((model) => {setState(() => model = currentUser)})
                      },
                    ),]
                )

              ],
              )
            ),
          onRefresh: () async {
            retrieveUser()
              .then((model) => {setState(() => model = currentUser)});
          }
          )

    );
  }
}
