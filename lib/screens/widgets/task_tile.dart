import 'package:flutter/material.dart';

class tasktile extends StatelessWidget {
  final bool? isChecked;
  final String tasktitle;
  final Function checkboxCallback;
  final Function longpressCallback;
  tasktile(
      {this.isChecked,
      required this.tasktitle,
      required this.checkboxCallback,
      required this.longpressCallback});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longpressCallback(),
      title: Text(
        tasktitle,
        style: TextStyle(
            decoration: isChecked! ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
          activeColor: Colors.lightBlueAccent,
          value: isChecked,
          onChanged: (newValue) {
            checkboxCallback(newValue);
          }),
      // onChanged: togglecheckboxState,
    );
  }
}

// (bool? checkboxState) {
//           setState(() {
//             isChecked = checkboxState;
//           });
//         }



