import 'package:flutter/material.dart';
import 'style.dart';
import 'widgets/ttform.dart';
import 'widgets/ttscaffold.dart';

class EditAccountPage extends StatelessWidget {
  const EditAccountPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return TTScaffold(title: "Edit Account", body: const EditAccountForm());
  }  
}  

class EditAccountForm extends StatefulWidget {
  const EditAccountForm({super.key});

  @override
  EditAccountFormState createState() => EditAccountFormState();

}

class EditAccountFormState extends State<EditAccountForm> {

  bool showPasswordFields = false;

  @override
  Widget build(BuildContext context) {
    return TTForm(
      children: <Widget>[  
        TTTextField(labelText: "Username/Email", initialValue: "Retrieve Username/Email here"),
        TTTextField(labelText: "Screen Name", initialValue: "Retrieve Screen Name here"),
        Padding(
            padding: const EdgeInsets.all(itemSpacing),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
              const Text('Update Password'),
              Checkbox(
              checkColor: Colors.white,
              value: showPasswordFields,
              onChanged: (bool? value) {
                setState(() {
                  showPasswordFields = value!;
                });
              },
            ),
            ],),
          ),
        showPasswordFields ? TTTextField(labelText: "New Password", obscureText: true) : Container(),
        showPasswordFields ? TTTextField(labelText: "Re-enter Password", obscureText: true) : Container(),
        Padding(
          padding: const EdgeInsets.all(itemSpacing),
          child: Center(
            child: TextButton(
            onPressed: null,  // form submission logic goes here
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryColor),
              elevation: MaterialStateProperty.all(5.0),
            ),
            child: const Text(
              'Update',
              style: TextStyle(
                color: textColorAgainstPrimary
              )
            ),
          ),
          )
        ),
      ],
    );  
  }

}