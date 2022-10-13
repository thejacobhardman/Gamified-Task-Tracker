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
  final TextEditingController _controllerFirstname = TextEditingController();
  final TextEditingController _controllerLastname = TextEditingController();


  void _createUser() async {
    var user = Users(
        userName: _controllerUsername.text,
        firstName: _controllerFirstname.text,
        lastName: _controllerLastname.text,
        password: _controllerPassword.text,
        email: _controllerEmail.text.toLowerCase(),
        team: null,
        admin: false,
        points: 0);
    var response = await access.post("/user", user).catchError((err) {});
    if (response == null) {
      return;
    } else {
      debugPrint("Successful");
    }
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
      if (_controllerFirstname.text == "" || _controllerLastname.text == "") {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Container(
                padding: const EdgeInsets.all(16),
                height: 90,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: const Text(
                    "First Name/Last Name fields not used, please try login again!"
                ),
              ),),
        );
        return;
      }
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
                visible: !isLogin,
                controller: _controllerFirstname,
                labelText: 'First Name'
            ),

            TTTextField(
                visible: !isLogin,
                controller: _controllerLastname,
                labelText: 'Last Name'
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



