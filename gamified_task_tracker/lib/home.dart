import 'package:flutter/material.dart';
import 'style.dart';
import 'widgets/ttform.dart';
import 'widgets/ttscaffold.dart';

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
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
          Padding(
            padding: const EdgeInsets.all(itemSpacing),
            child: Center(
              child: const Text('Name of App Here',
              style: TextStyle(color: Colors.white, fontSize: 30)),
            )
          ),
          Padding(
            padding: const EdgeInsets.all(itemSpacing),
            child: Center(
              child: SizedBox (
                width: 200,
                height: 50,
                child: TextButton(
                  onPressed: null,  // form submission logic goes here
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
                  onPressed: null,  // form submission logic goes here
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
    ],);
  }

}