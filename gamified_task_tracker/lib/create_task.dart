import 'package:flutter/material.dart';
import 'ttform.dart';

const Color backgroundColor = Colors.white;
const Color textColor = Colors.black;
const Color textColorAgainstPrimary = Colors.white;
const Color primaryColor = Colors.purple;

const double edgeInsets = 40.0;

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text(
              "Add Task",
              style: TextStyle(
                color: textColorAgainstPrimary,
              )
          ),
          centerTitle: true,
          leading: GestureDetector(
              child: const Icon(
                Icons.arrow_back,
                color: textColorAgainstPrimary,
              )
          ),
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
            Container(
          padding: const EdgeInsets.all(edgeInsets),
          child: const CreateTaskForm()
          )
        )
      );
  }  
}  

class CreateTaskForm extends StatefulWidget {
  const CreateTaskForm({super.key});

  @override
  CreateTaskFormState createState() => CreateTaskFormState();

}

class CreateTaskFormState extends State<CreateTaskForm> {

  final _formKey = GlobalKey<FormState>();  

  bool showTimingFields = false;

  @override
  Widget build(BuildContext context) {

    return Form(  
      key: _formKey,  
      child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,  
        children: <Widget>[  
          TTTextField(labelText: "Task Name"),
          TTTextField(labelText: "Description", maxLines: 5),
          TTTextField(labelText: "Points"),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
              const Text('Timed?'),
              Checkbox(
              checkColor: Colors.white,
              value: showTimingFields,
              onChanged: (bool? value) {
                setState(() {
                  showTimingFields = value!;
                });
              },
            ),
            ],),
          ),
          showTimingFields ? Row(
            mainAxisSize: MainAxisSize.max,
            children: [
            Expanded(child:TTTextField(labelText: "Days")),
            Expanded(child:TTTextField(labelText: "Hours")),
            Expanded(child:TTTextField(labelText: "Minutes")),
          ],) : Container(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextButton(
              onPressed: null,  // form submission logic goes here
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(primaryColor),
                elevation: MaterialStateProperty.all(5.0),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: textColorAgainstPrimary
                )
              ),
            ),
          ),
        ],  
      ),  
    );  
  }

}