import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'pages/tasks_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.email)),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: passController,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.password)),
            ),
            SizedBox(
              height: 45,
            ),
            OutlinedButton.icon(
                onPressed: () {
                  login(passController, emailController, context);
                },
                icon: Icon(
                  Icons.login,
                  size: 18,
                ),
                label: Text("Login")),
          ],
        ))),
      ),
    );
  }
}

//function calls login post api
Future<void> login(passController, emailController, context) async {
  /* if (passController.text.isNotEmpty && emailController.text.isNotEmpty) {
    var response = await http.post(Uri.parse("http://10.0.2.2:8000"),
        body: ({
          'email': emailController.text,
          'password': passController.text
        }));
    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DataFromAPI()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid Credentials")));
    }
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("One or more fields are emtpy")));
  } */
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => DataFromAPI()));
}
