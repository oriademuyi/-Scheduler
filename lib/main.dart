import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:muyi_todo/models/task_date.dart';
import 'package:muyi_todo/screens/authentication/login.dart';
import 'package:muyi_todo/screens/authentication/register.dart';
import 'package:muyi_todo/screens/heloworld.dart';
import 'package:muyi_todo/screens/task_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<TaskData>(
//       create: (_) => TaskData(),
//       child: MaterialApp(home: loginPage()

//           //  TasksScreen(),
//           ),
//     );
//   }
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');

  await Firebase.initializeApp();
  runApp(MaterialApp(
    // home: helloword(),
    home: email == null ? loginPage() : TasksScreen(),
  ));
}




// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SbvharedPreferences prefs = await SharedPreferences.getInstance();
//   var email = prefs.getString('email');
// return  
// }
