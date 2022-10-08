import '../Models/users.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage(this.user, {super.key});
  final Users user;



  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override

  void setUserValues() {
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile Page - ${widget.user.userName!}' ?? "Profile Page"),
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
            Text(widget.user.points!.toString() ?? "no points - do some tasks!"),
          ],
        )

        );
  }
}
