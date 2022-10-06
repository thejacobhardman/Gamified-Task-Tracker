import 'package:flutter/material.dart';
import 'package:gamified_task_tracker/widgets/ttscaffold.dart';
import 'create-account.dart';
import 'style.dart';
import 'widgets/ttform.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: TTScaffold(
        bgColor: backgroundColor,
        title: '',
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 150.0, horizontal: 15.0),
            child: Column(
            children: <Widget>[
              
              const Text('Login',
              style: TextStyle(color: textColor, fontSize: 30)),
              TTTextField(labelText: 'Username/Email', maxLines: 1),
              TTTextField(labelText: 'Password', maxLines: 1),

             TextButton(
                style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                
            ),
            onPressed: null,
            child: const Text('Login', style: TextStyle(color: textColorAgainstPrimary) )),
        
           TextButton(
                style: TextButton.styleFrom(
            ),

            onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateAccountPage())),  // form submission logic goes here
                 
           child: const Text('Create Account', style: TextStyle(color: primaryColor) )),

            

              

            ],
          ),
          )
  
          
        ),
      ),
    );
  }
}