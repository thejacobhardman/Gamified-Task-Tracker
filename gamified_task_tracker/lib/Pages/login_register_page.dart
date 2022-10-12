import 'package:flutter/material.dart';
import 'package:gamified_task_tracker/widgets/ttscaffold.dart';
import '../Views/RemoteAccess.dart';
import '../Views/style.dart';
import '../widgets/ttform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamified_task_tracker/Models/users.dart';
import '../Views/auth.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
  
}

class _LoginPageState extends State<LoginPage> {

  String? errorMessage = '';
  bool isLogin = true;
  RemoteAccess access = RemoteAccess();

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();

  void _createUser() async {
    var user = Users(
        userName: _controllerUsername.text,
        firstName: "TestFirstName",
        lastName: "TestLastName",
        password: _controllerPassword.text,
        email: _controllerEmail.text.toLowerCase(),
        team: null,
        admin: false,
        points: 0);
    var response = await access.post("/user", user).catchError((err) {});
    if (response == null) {
      return;
    }
    debugPrint("Successful");
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      print(_controllerEmail.text);
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        print(e.code);
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      _createUser();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TTScaffold(
      bgColor: backgroundColor,
      title: '',
      hasAppBar: false,
      body: TTForm(
          children: <Widget>[

            TTFormElement(
              child: Image.asset("assets/images/logo.png"),
            ),
            
            const TTFormElement(
              verticalPaddingOnly: true,
              child: TTText(
                'Gamified Task Tracker',
                color: textColor, 
                size: 30,
                ),
              ),

            TTTextField(
              visible: !isLogin,
              controller: _controllerUsername,
              labelText: 'Username'
              ),

            TTTextField(
              controller: _controllerEmail,
              labelText: 'Email'
              ),

            TTTextField(
              controller: _controllerPassword,
              obscureText: true,
              labelText: 'Password'
              ),

            TTFormElement(
              child: Text(
                errorMessage == '' ? '' : 'Hmm ? $errorMessage'
                ),
              ),
            
            TTButton(
              text: isLogin ? 'Login' : 'Register',
              onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
              ),

            TTButton(
              text: isLogin ? 'Register instead' : 'Login instead',
              onPressed: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
              ),

          ],
        ),
      );
  }
}



