import 'package:flutter/material.dart';
import '../style.dart';

// You can use this widget to set up your scaffolding automatically

class TTScaffold extends StatelessWidget {

  final String title;
  Widget body;

  TTScaffold({super.key, required this.title, required this.body});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text(
              title,
              style: TextStyle(
                color: textColorAgainstPrimary,
              )
          ),
          centerTitle: true,
          leading: GestureDetector(
              child: const Icon(
                Icons.arrow_back,
                color: textColorAgainstPrimary,
              )
          ),
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
            Container(
          padding: const EdgeInsets.all(edgeInsets),
          child: body
          )
        )
      );
  }  
}  