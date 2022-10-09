import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:gamified_task_tracker/RemoteAccess.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

import '../Models/task.dart';
import '../Models/users.dart';

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
  DateTime selectedDate = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  int _currentIntValue = 0;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFEE8B60),
        automaticallyImplyLeading: true,
        title: Text(
          'Task App',
          style: GoogleFonts.getFont(
            'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFF1F4F8),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TextFormField(
                controller: textController1,
                decoration: InputDecoration(hintText: "Task Name"),
              ),
              TextFormField(
                controller: textController2,
                decoration: InputDecoration(hintText: "Task Details"),
              ),
              SizedBox(height: 16),
              Text('Points', style: Theme.of(context).textTheme.headline6),
              NumberPicker(
                value: _currentIntValue,
                minValue: 0,
                maxValue: 1000,
                step: 10,
                haptics: true,
                onChanged: (value) => setState(() => _currentIntValue = value),
              ),
              ElevatedButton(
                  onPressed: pickDate, child: const Text("Due Date")),
              ElevatedButton(
                  onPressed: _postTask, child: const Text("Post Test Task"))
            ],
          ),
        ),
      ),
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
  }

  void pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
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
