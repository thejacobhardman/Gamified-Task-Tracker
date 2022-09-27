import 'package:flutter/material.dart';

const Color backgroundColor = Colors.indigo;
const Color textColor = Colors.white;
const double edgeInsets = 40.0;

class FieldRow extends StatelessWidget {

  final String title;
  final Widget child;

  FieldRow({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
            children: <Widget>[
              Row(
                  children: <Widget>[
                    Text(
                        title,
                        style: const TextStyle(
                          color: textColor,
                        )
                    ),
                  ]
              ),
              const SizedBox(height: 10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    child
                  ]
              ),
              const SizedBox(height: 40),
            ]
        )
      ],
    );
  }
}

class TaskTextField extends StatelessWidget {

  final int lines;
  final double width;
  final String hint;

  const TaskTextField({super.key, this.lines = 1, this.width = 0, this.hint = ''});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width == 0 ? MediaQuery.of(context).size.width - (edgeInsets * 2) : width,
        child: TextField(
          textAlign: TextAlign.center,
          maxLines: lines,
          cursorColor: textColor,
          style: const TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.blueGrey
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: textColor,
                  width: 3,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: textColor,
                  width: 3,
              ),
            ),
          ),
        ),
    );
  }
}

class CreateTaskPage extends StatelessWidget {

  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {

    double pageWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text(
              "Add Task",
              style: TextStyle(
                color: textColor,
              )
          ),
          centerTitle: true,
          leading: GestureDetector(
              child: const Icon(
                Icons.arrow_back,
                color: textColor,
              )
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,

        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
            Container(
          padding: const EdgeInsets.all(edgeInsets),
          child: Column(
            children: [
              FieldRow(
                title: "Task Name",
                child: TaskTextField()
              ),
              FieldRow(
                  title: "Task Description",
                  child: TaskTextField(
                      lines: 3
                  )
              ),
              FieldRow(
                title: "Points",
                child: TaskTextField()
              ),
              FieldRow(
                  title: "Time",
                  child: Row(
                    children: [
                      TaskTextField(
                        width: (pageWidth - (edgeInsets * 3)) / 3,
                        hint: "Days",
                      ),
                      const SizedBox(width: edgeInsets / 2),
                      TaskTextField(
                        width: (pageWidth - (edgeInsets * 3)) / 3,
                        hint: "Hours",
                        ),
                      const SizedBox(width: edgeInsets / 2),
                      TaskTextField(
                        width: (pageWidth - (edgeInsets * 3)) / 3,
                        hint: "Minutes",
                        ),
                  ])
              ),
              OutlinedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(textColor),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered))
                        return textColor.withOpacity(0.04);
                      if (states.contains(MaterialState.focused) ||
                          states.contains(MaterialState.pressed))
                        return textColor.withOpacity(0.12);
                      return null; // Defer to the widget's default.
                    },
                  ),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.white, width: 2.0)
                    )),
                ),
                onPressed: () { },
                child: Text('Add'),
              )
            ]
          )
        )
        )
    );
  }

}