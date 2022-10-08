import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:gamified_task_tracker/RemoteAccess.dart';
import 'package:google_fonts/google_fonts.dart';

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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: TextFormField(
                  controller: textController1,
                  onChanged: (_) => EasyDebounce.debounce(
                    'textController1',
                    Duration(milliseconds: 2000),
                        () => setState(() {}),
                  ),
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Enter Task Name Here...',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE0E3E7),
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE0E3E7),
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                  ),
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Color(0xFF101213),
                    fontWeight: FontWeight.w200,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: TextFormField(
                    controller: textController2,
                    onChanged: (_) => EasyDebounce.debounce(
                      'textController2',
                      Duration(milliseconds: 2000),
                          () => setState(() {}),
                    ),
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Enter Task Details Here...',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      filled: true,
                      contentPadding:
                      EdgeInsetsDirectional.fromSTEB(0, 0, 0, 400),
                    ),
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: Color(0xFF101213),
                      fontWeight: FontWeight.w100,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20)
                ),
              ),
              ElevatedButton(onPressed: _postTask,
                  child: const Text("Post Test Task"))
            ],
          ),
        ),
      ),
    );
  }

  Future _postTask() async {
    var newTask = Task(
      taskName: 'taskRick',
      description: 'Look Morty, I turned myself into a task! I\'M TASK RIIICK',
      completed: false,
      completedby: null,
      valid: false,
      dueDate: "10/06/2022",
      authorKey: widget.user.id,
      team: widget.user.team,
      points: 69,
    );
    var response =
    await access.post("/task", newTask).catchError((err) {});
    if (response == null) {
      print("null");
      return;
    }
    debugPrint("Successful");
  }
}
