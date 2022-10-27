import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:muyi_todo/models/task.dart';
import 'package:muyi_todo/models/task_date.dart';
import 'package:muyi_todo/screens/add_task_screen.dart';
import 'package:muyi_todo/screens/authentication/login.dart';

import 'package:muyi_todo/screens/widgets/task_list.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

final _firstore = FirebaseFirestore.instance;

class TasksScreen extends StatefulWidget {
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  // void getUserinfo() async {
  //   final UserInfo = await _firstore.collection('todousers').get();
  //   for (var userinfo in UserInfo.docs) {
  //     print(userinfo.data());
  //   }
  // }

  static final DateTime currenttime = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(currenttime);

  String dateFormat = DateFormat('dd-MM-yyyy hh:mm').format(currenttime);
  var hour = DateTime.now().hour;

  // List<Task> tasks = [
  //   Task(name: "buy rice"),
  //   Task(name: "buy beans"),
  //   Task(name: "buy bread")
  // ];
  final FirebaseAuth auth = FirebaseAuth.instance;

  void inputData() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    final uemmail = user.email;
    print(' this is my  user id $uid');
    print('this is my current email $uemmail');

    // here you write the codes to input the data into firestore
  }

  void getimageurl() async {
    final ref = FirebaseStorage.instance.ref().child('muyiwa/');
// no need of the file extension, the name will do fine.
    var url = await ref.getDownloadURL();
    print(url);
  }

  String? _timeString;
  String? _timeStringhour;
  String? _timeStringminutes;
  String? _timeStringseconds;

  @override
  void initState() {
    _timeString =
        "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getCurrentTime());
    super.initState();
  }

  void _getCurrentTime() {
    setState(() {
      _timeString =
          "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
      _timeStringhour = "${DateTime.now().hour}";
      _timeStringminutes = "${DateTime.now().minute}";
      _timeStringseconds = "${DateTime.now().second}";
    });
  }

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent,
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => AddTaskScreen(),
              // {
              //   // setState(() {
              //   //   tasks.add(Task(name: newTaskTittle));
              //   //   Navigator.pop(context);
              //   // });
              // }),
            );
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.remove("email");
                      await prefs.clear();
                      print(prefs.getString('email'));
                      _auth.signOut().then(
                        (_) {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                            builder: (context) {
                              return const loginPage();
                            },
                          ), (Route<dynamic> route) => false);
                        },
                      );
                    },
                    child: Icon(
                      Icons.logout,
                      color: Colors.red,
                      size: 20.0,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    hour < 12
                        ? "Good morning"
                        : hour < 17
                            ? "Good afternoon"
                            : "Good evening",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0, left: 30, right: 30, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              getimageurl();
                              // inputData();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50,
                              child: Image.asset(
                                'assets/muyi.jpeg',
                                height: 80,
                                width: 60,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          StreamBuilder<QuerySnapshot>(
                              stream: _firstore
                                  .collection('todousers')
                                  .where('useremail', isEqualTo: user!.email)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final userdata = snapshot.data!.docs;
                                  List<Text> userdatawidget = [];
                                  String useremail = "";
                                  String userename = "";
                                  for (var userinfor in userdata) {
                                    var data = userinfor.data() as Map;
                                    useremail = data['useremail'];
                                    userename = data['fullname'];

                                    final messagewidget = Text(
                                      '$userename from  $useremail',
                                      // style: TextStyle(color: Colors.red

                                      // ),
                                    );

                                    userdatawidget.add(messagewidget);
                                  }
                                  return Column(children: [
                                    Text(
                                      'Welcome $userename',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      useremail,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ]);
                                } else {
                                  return Container();
                                }
                              }),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: Text(_timeStringhour.toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.lightBlueAccent,
                            )),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: Text(_timeStringminutes.toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.lightBlueAccent,
                            )),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: Text(_timeStringseconds.toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.lightBlueAccent,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Text(
                  //   "Todoey",
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 50,
                  //       fontWeight: FontWeight.w700),
                  // ),
                  // Text(
                  //   "${Provider.of<TaskData>(context).taskCount} task",
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 18,
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Text(
                      "${DateFormat('EEEE').format(currenttime)},  ${formatted.toString()}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                    ),
                  ),

                  // Text(
                  //   _timeString.toString(),
                  //   style: TextStyle(fontSize: 30),
                  // ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: taskList(),
              ),
            )
          ],
        ));
  }
}


