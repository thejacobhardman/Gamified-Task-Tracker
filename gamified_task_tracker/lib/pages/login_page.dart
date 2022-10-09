import 'package:flutter/material.dart';
import 'package:gamified_task_tracker/widgets/ttscaffold.dart';
import 'create_account.dart';
import '../style.dart';
import '../widgets/ttform.dart';
import 'view_tasks.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TTScaffold(
     
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
                onPressed:  () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewTasksPage(
                            // generate list
                            tasks: List.generate(
                              10,
                              (i) => Task(
                                'Task $i',
                                'Task Description $i',
                                'Points $i',
                              ),
                              ),
                            ),
                          )),
                child: const Text('Login', style: TextStyle(color: textColorAgainstPrimary) )),
        
              TextButton(
                onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateAccountPage()
                          )),  // form submission logic goes here
                  
                child: const Text('Create Account', style: TextStyle(color: primaryColor) )),

            ],
          ),
          )
  
          
        ),
      );
   
  }
}