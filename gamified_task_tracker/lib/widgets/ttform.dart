import 'package:flutter/material.dart';
import '../Views/style.dart';
import 'package:google_fonts/google_fonts.dart';

// Here are some pre-built widgets for use in fields across our app

/// Creates a simple form with a column where we can put our fields
/// 
/// The children field should be a list of widgets that are the fields of our form
class TTForm extends StatefulWidget {

  final List<Widget> children;

  const TTForm({super.key, required this.children});

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

/// Text field to be used as a child of a TTForm instance
class TTTextField extends StatefulWidget {

  final String labelText;
  final int maxLines;
  final bool obscureText;
  final String? initialValue;
  final TextEditingController? controller;
  final bool visible;

  const TTTextField({
    super.key, 
    required this.labelText, 
    this.maxLines = 1, 
    this.obscureText = false, 
    this.initialValue, 
    this.controller,
    this.visible = true,
    });

  @override
  TTTextFieldState createState() => TTTextFieldState();
}

class TTTextFieldState extends State<TTTextField> {

  @override
  Widget build(BuildContext context) {
    return TTFormElement(
      visible: widget.visible,
      child: TextFormField(
        controller: widget.controller,
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

/// Checkbox with a label
class TTCheckbox extends StatefulWidget {

  final bool value;
  final bool visible;
  final void Function(bool?) onChanged;
  final String text;

  const TTCheckbox({
    super.key, 
    this.text = "", 
    this.visible = true, 
    required this.onChanged,
    required this.value,
    });

  @override
  TTCheckboxState createState() => TTCheckboxState();
}

class TTCheckboxState extends State<TTCheckbox> {

  @override
  Widget build(BuildContext context) {
    return TTFormElement(
      visible: widget.visible,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          TTText(widget.text),
          Checkbox(
            checkColor: Colors.white,
            value: widget.value,
            onChanged: widget.onChanged,
            ),
          ],
        ),
      );
  }
}

/// Button to be used as a child of a TTForm instance
class TTButton extends StatefulWidget {

  final String text;
  final bool visible;
  final Color backgroundColor;
  final Color textColor;
  final void Function()? onPressed;

  const TTButton({
    super.key, 
    this.text = "", 
    this.visible = true, 
    this.backgroundColor = primaryColor, 
    this.textColor = textColorAgainstPrimary, 
    required this.onPressed,
    });

  @override
  TTButtonState createState() => TTButtonState();
}

class TTButtonState extends State<TTButton> {

  @override
  Widget build(BuildContext context) {
    return TTFormElement(
      visible: widget.visible,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          elevation: 8,
          ),
        onPressed: widget.onPressed,
        child: TTText(
          widget.text, 
          color: widget.textColor,
          ),
        ),
      );
  }
}

/// Creates basic text element
class TTText extends StatefulWidget {

  final String text;
  final Color color;
  final double size;
  final TextAlign align;

  const TTText(
    this.text,
    {super.key,
    this.color = textColor, 
    this.size = 16,
    this.align = TextAlign.center
    });

  @override
  TTTextState createState() => TTTextState();
}

class TTTextState extends State<TTText> {

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      textAlign: widget.align,
      style: GoogleFonts.getFont(
        'Poppins',
        color: widget.color,
        fontWeight: FontWeight.w400,
        fontSize: widget.size
      ),
    );
  }
}

/// Use this if you want to put your own custom widget into a TTForm, such as some simple text
/// 
/// All this really does is create padding and allow for the toggling of visibility
class TTFormElement extends StatelessWidget {

  final bool verticalPaddingOnly;
  final bool visible;
  final Widget child;

  const TTFormElement({
    super.key, 
    this.visible = true,
    this.verticalPaddingOnly = false,
    required this.child,
    });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        visible: visible,
        child: Padding(
          padding: verticalPaddingOnly ? const EdgeInsets.only(top: itemSpacing, bottom: itemSpacing) : const EdgeInsets.all(itemSpacing),
          child: child,
          )
        )
      );
  }
}