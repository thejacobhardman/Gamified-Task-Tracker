import 'package:flutter/material.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 122, 67, 143),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 150.0, horizontal: 15.0),
            child: Column(
            children: <Widget>[
              const Text('Create Account',
              style: TextStyle(color: Colors.white, fontSize: 30)),
              const TextField(decoration: InputDecoration(hintText:'Username/Email', hintStyle: TextStyle(color:Colors.white))),
              const TextField(decoration: InputDecoration(hintText:'Screen Name', hintStyle: TextStyle(color:Colors.white))),
              const TextField(decoration: InputDecoration(hintText:'Password', hintStyle: TextStyle(color:Colors.white))),
               TextButton(
                style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 170, 129, 187),
                textStyle: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            onPressed: null,
            child: const Text('Create Account')),

            

              

            ],
          ),
          )
  
          
        ),
      ),
    );
  }
}