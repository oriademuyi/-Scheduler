import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muyi_todo/models/task.dart';
import 'package:muyi_todo/models/task.dart';
import 'package:muyi_todo/models/task_date.dart';
import 'package:provider/provider.dart';

final _firstore = FirebaseFirestore.instance;

class AddTaskScreen extends StatefulWidget {
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String? newTaskTittle;
  String? listedtime;
  String? completedtime;
  DateTime selectedDate = DateTime.now();
  DateTime selectcompletedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectcompletedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectcompletedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectcompletedDate) {
      setState(() {
        selectcompletedDate = picked;
      });
    }
  }

  // final Function adTaskCallback;
  _showErrorFailure() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.25,
          child: StatefulBuilder(builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    width: double.infinity,
                    height: 250,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Congratulations",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 8.0,
                              bottom: 15.0,
                            ),
                            child: Icon(
                              Icons.cancel,
                              color: Colors.red,
                              size: 80,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 6.0, left: 30, right: 30),
                          child: Text(
                            "Your todo list has been added sucessful",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 70,
                          ),
                          child: SizedBox(
                            width: 100,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.green),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              child: Text("ok"),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add task",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Colors.lightBlueAccent,
              ),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                newTaskTittle = newText;
              },
            ),

            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: [
                    TextButton(
                      onPressed: () => _selectDate(context),
                      child: Text('Select  start date'),
                    ),
                    Icon(Icons.calendar_today),
                    SizedBox(
                      width: 100,
                    ),
                    Text("${selectedDate.toLocal()}".split(' ')[0]),
                  ],
                ),
              ],
            ),

            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: [
                    TextButton(
                      onPressed: () => _selectcompletedDate(context),
                      child: Text('Select  Completed date'),
                    ),
                    Icon(Icons.calendar_today),
                    SizedBox(
                      width: 60,
                    ),
                    Text("${selectcompletedDate.toLocal()}".split(' ')[0]),
                  ],
                ),
              ],
            ),
            // TextField(
            //   keyboardType: TextInputType.emailAddress,
            //   textAlign: TextAlign.center,
            //   onChanged: (value) {
            //     setState(() {
            //       listedtime = value.trim();
            //     });

            //     //Do something with the user input.
            //   },
            //   decoration: InputDecoration(
            //     hintText: 'Enter listed time',
            //     contentPadding:
            //         EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(32.0)),
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
            //       borderRadius: BorderRadius.all(Radius.circular(32.0)),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
            //       borderRadius: BorderRadius.all(Radius.circular(32.0)),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            // TextField(
            //   keyboardType: TextInputType.emailAddress,
            //   textAlign: TextAlign.center,
            //   onChanged: (value) {
            //     completedtime = value;
            //     //Do something with the user input.
            //   },
            //   decoration: InputDecoration(
            //     hintText: 'Enter completed time',
            //     contentPadding:
            //         EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(32.0)),
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
            //       borderRadius: BorderRadius.all(Radius.circular(32.0)),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
            //       borderRadius: BorderRadius.all(Radius.circular(32.0)),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            Container(
              color: Colors.lightBlueAccent,
              child: TextButton(
                  onPressed: () {
                    // print(selectedDate.toLocal());
                    // print(selectcompletedDate.toLocal());
                    // print('title $newTaskTittle');
                    // print(' lt $listedtime');
                    // print(' ct $completedtime');
                    // print(user!.uid);

                    try {
                      _firstore.collection('todolist').add({
                        'todo': newTaskTittle,
                        'listedtime': selectedDate.toLocal(),
                        'completedtime': selectcompletedDate.toLocal(),
                        'uid': user!.uid,
                      });
                      Navigator.pop(context);

                      print("its suceessful bro");
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
