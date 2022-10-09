import 'package:flutter/material.dart';
import '../style.dart';
import '../widgets/ttscaffold.dart';
import 'login_page.dart';
import 'create_account.dart';
import 'create_task.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return TTScaffold(
      title: "",
      hasAppBar: false,
      bgColor: primaryColor,
      body: const HomePageBody(),
      scrollable: false,
    );
  }  
}  

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  HomePageBodyState createState() => HomePageBodyState();

}

class HomePageBodyState extends State<HomePageBody> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, bottom: 80),
      child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
          const Padding(
            padding: EdgeInsets.all(itemSpacing),
            child: Center(
              child: Text('Name of App Here',
              style: TextStyle(color: Colors.white, fontSize: 30)),
            )
          ),
          Padding(padding: EdgeInsets.all(5)),
          Padding(
            padding: const EdgeInsets.all(itemSpacing),
            child: Center(
              child: SizedBox (
                width: 200,
                height: 50,
                child: TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage())),  // form submission logic goes here
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(backgroundColor),
                      elevation: MaterialStateProperty.all(5.0),
                    ),
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      color: textColor
                    )
                  ),
                ),
                )
            )
          ),
          Padding(
            padding: const EdgeInsets.all(itemSpacing),
            child: Center(
              child: SizedBox (
                width: 200,
                height: 50,
                child: TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateAccountPage())),  // form submission logic goes here
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(backgroundColor),
                  elevation: MaterialStateProperty.all(5.0),
                ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: textColor
                    )
                  ),
                ),
                )
            )
          ),
    ],)
    );
  }

}