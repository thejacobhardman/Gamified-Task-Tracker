import 'package:flutter/material.dart';
import '../Views/style.dart';
import 'package:google_fonts/google_fonts.dart';

// You can use this widget to set up your scaffolding automatically

class TTScaffold extends StatelessWidget {

  final String title;
  final Widget body;
  final bool hasAppBar;
  final Color bgColor;
  final bool scrollable;
  final FloatingActionButton? floatingActionButton;

  const TTScaffold({
    super.key, 
    required this.title, 
    required this.body, 
    this.hasAppBar = true, 
    this.bgColor = backgroundColor, 
    this.scrollable = true,
    this.floatingActionButton,
    });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: hasAppBar ? AppBar(
          title: Text(
            title,
            style: GoogleFonts.getFont(
              'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 30,
            ),
          ),
          centerTitle: true,
          leading: const BackButton(color: backgroundColor),
          backgroundColor: primaryColor,
        ) : null,
        body: Center(
          child: scrollable ? SingleChildScrollView(
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
        ),
        floatingActionButton: floatingActionButton,
      );
  }  
}  