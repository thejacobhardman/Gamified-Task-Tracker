import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

import '../Models/task.dart';
import '../Models/users.dart';
import '../Views/RemoteAccess.dart';
import '../Views/style.dart';

import '../widgets/ttscaffold.dart';
import '../widgets/ttform.dart';

class CreateATaskPage extends StatefulWidget {
  const CreateATaskPage(this.user, {super.key});
  final Users user;

  @override
  _CreateATaskPageState createState() => _CreateATaskPageState();
}

class _CreateATaskPageState extends State<CreateATaskPage> {
  TextEditingController? textController1;
  TextEditingController? textController2;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  RemoteAccess access = RemoteAccess();
  DateTime selectedDate = DateTime(3000);
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  int _currentIntValue = 0;

  bool showTimingFields = false;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    print(formatter.format(selectedDate));
    return TTScaffold(
      title: 'Create a Task',
      body: TTForm(
        children: <Widget>[  

          TTTextField(controller: textController1, labelText: "Task Name"),

          TTTextField(controller: textController2, labelText: "Description", maxLines: 5),
          
          TTFormElement(
            child: Column(
              children: [
                const TTText('Points'),
                NumberPicker(
                  value: _currentIntValue,
                  minValue: 0,
                  maxValue: 1000,
                  step: 10,
                  haptics: true,
                  onChanged: (value) => setState(() => _currentIntValue = value),
                  ),
                ],
              )
            ),
          
          Row(
            children: [

              TTCheckbox(
                text: 'Timed?',
                onChanged: (bool? value) {
                    setState(() {
                      showTimingFields = value!;
                    });
                  },
                value: showTimingFields
                ),

              showTimingFields ? TTButton(
                text: "Select Date",
                onPressed: pickDate,
                ) : TTFormElement(child: Container()),
                
            ],
            ),

          TTButton(
            text: 'Add',
            backgroundColor: createColor,
            onPressed: _postTask,
            )

        ],  
      )
    );
  }

  Future _postTask() async {

    var newTask = Task(
      taskName: textController1?.text ?? "",
      description: textController2?.text ?? "",
      completed: false,
      completedby: "",
      valid: false,
      dueDate: formatter.format(selectedDate),
      authorKey: widget.user.id,
      team: widget.user.team,
      points: _currentIntValue,
    );
    var response = await access.post("/task", newTask).catchError((err) {});
    if (response == null) {
      print("null");
      return;
    }
    debugPrint("Successful");
    Navigator.pop(context);
  }

  void pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor, // <-- SEE HERE
              onPrimary: textColorAgainstPrimary, // <-- SEE HERE
              onSurface: Colors.blueAccent, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: primaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      String formatted = formatter.format(selectedDate);
      print(formatted);
    }
  }
}
