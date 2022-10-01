import 'package:flutter/material.dart';

// Here are some pre-built widgets for use in fields across our app

class TTTextField extends StatefulWidget {

  String labelText;
  int maxLines;

  TTTextField({super.key, required this.labelText, this.maxLines = 1});

  @override
  TTTextFieldState createState() => TTTextFieldState();

}

class TTTextFieldState extends State<TTTextField> {

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
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