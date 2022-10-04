import 'package:flutter/material.dart';
import 'style.dart';
import 'widgets/ttform.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 150.0, horizontal: 15.0),
            child: Column(
            children: <Widget>[
              const Text('Create Account',
              style: TextStyle(color: textColor, fontSize: 30)),
              TTTextField(labelText: 'Username/Email', maxLines: 1),
              TTTextField(labelText: 'Screen Name', maxLines: 1),
              TTTextField(labelText: 'Password', maxLines: 1),
          
               TextButton(
                style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                textStyle: const TextStyle(fontSize: 20, color: textColorAgainstPrimary),
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