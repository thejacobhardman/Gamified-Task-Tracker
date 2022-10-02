import 'package:flutter/material.dart';
import '../style.dart';

// Here are some pre-built widgets for use in fields across our app


class TTForm extends StatefulWidget {

  List<Widget> children;

  TTForm({super.key, required this.children});

  @override
  TTFormState createState() => TTFormState();

}

class TTFormState extends State<TTForm> {

  final _formKey = GlobalKey<FormState>();  

  bool showTimingFields = false;

  @override
  Widget build(BuildContext context) {

    return Form(  
      key: _formKey,  
      child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,  
        children: widget.children,
      ),  
    );  
  }

}


class TTTextField extends StatefulWidget {

  String labelText;
  int maxLines;
  bool obscureText;
  String initialValue;

  TTTextField({super.key, required this.labelText, this.maxLines = 1, this.obscureText = false, this.initialValue = ""});

  @override
  TTTextFieldState createState() => TTTextFieldState();

}

class TTTextFieldState extends State<TTTextField> {

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(itemSpacing),
            child: TextFormField(
              initialValue: widget.initialValue,
              obscureText: widget.obscureText,
              maxLines: widget.maxLines,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: widget.labelText,
                focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.0),
                        ),
                      ),
                enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.0),
                        ),
                      ),
              ),  
            ),  
          );
  }
}