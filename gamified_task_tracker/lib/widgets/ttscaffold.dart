import 'package:flutter/material.dart';
import '../style.dart';

// You can use this widget to set up your scaffolding automatically

class TTScaffold extends StatelessWidget {

  final String title;
  Widget body;
  bool hasAppBar;
  Color bgColor;
  bool scrollable;

  TTScaffold({super.key, required this.title, required this.body, this.hasAppBar = true, this.bgColor = backgroundColor, this.scrollable = true});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: hasAppBar ? AppBar(
          title: Text(
              title,
              style: TextStyle(
                color: textColorAgainstPrimary,
              )
          ),
          centerTitle: true,
          leading: GestureDetector(
              child: BackButton(color: backgroundColor)
          ),
          backgroundColor: primaryColor,
        ) : null,
        body: scrollable ? SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
            Container(
          padding: const EdgeInsets.all(edgeInsets),
          child: body
          )
        ) : Container(
          padding: const EdgeInsets.all(edgeInsets),
          child: body
          )
      );
  }  
}  