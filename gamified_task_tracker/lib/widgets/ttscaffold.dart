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


class TTLoadListScaffold extends StatelessWidget {

  final String title;
  final bool isLoaded;
  final List<Object>? list;
  final Widget Function(BuildContext, int) itemBuilder;
  final Future<void> Function() onRefresh;
  final Color bgColor;
  
  const TTLoadListScaffold({
    super.key, 
    required this.title,
    required this.isLoaded,
    required this.list,
    required this.itemBuilder,
    required this.onRefresh,
    this.bgColor = backgroundColor
    });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
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
          backgroundColor: primaryColor,
        ),
        body: isLoaded
          ? RefreshIndicator(
              onRefresh: onRefresh,
              child: Visibility(
                visible: isLoaded,
                child: ListView.builder(
                  itemCount: list?.length,
                  itemBuilder: itemBuilder
                ),
              ),
              )
          : const Center(
              child: CircularProgressIndicator(),
            )
          );
  }  
}  