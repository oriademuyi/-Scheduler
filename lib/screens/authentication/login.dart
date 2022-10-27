import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:muyi_todo/screens/authentication/register.dart';
import 'package:muyi_todo/screens/task_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  String? _email;
  String? _password;
  final _auth = FirebaseAuth.instance;
  bool _isObscure = true;

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
                    height: 300,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Forbidden!",
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
                            "There is no user record corresponding to this EMAIL or the PASSWORD is incorrect.",
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
                              child: Text("Try again"),
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

  _showresetpasswordsucess() {
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
                    height: 300,
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
                              Icons.check,
                              color: Colors.green,
                              size: 80,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 6.0, left: 30, right: 30),
                          child: Text(
                            "Kindly check your email for reset  confirmation",
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

  _showresetpasswordFailure() {
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
                    height: 300,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Forbidden!",
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
                            "This email is not found in our record,kindly input registered email",
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
                              child: Text("Try again"),
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

  final GlobalKey<FormState> _formouKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: [
        Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formouKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Container(
                  padding: EdgeInsets.all(40),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Icon(
                    Icons.add_task,
                    size: 60,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 300,
                child: Column(
                  children: [
                    Text(
                      "Welcome to Schedule",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Sign in to save and plan  all your schedules and access them anywhere",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, height: 1.5),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide.none),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _email = value.trim();
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: TextFormField(
                  obscureText: _isObscure,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: TextStyle(color: Colors.black),
                  validator: (value) {
                    _password = value;
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    if (value.trim().length < 8) {
                      return 'Password must be at least 8 characters in length';
                    }
                    // Return null if the entered password is valid
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    hintText: 'password',
                    suffixIcon: IconButton(
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }),
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide.none),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _password = value.trim();
                    });
                  },
                ),
              ),

              Container(
                margin: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TextButton(
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () async {
                    print('${_email}, ${_password}');
                    if (_formouKey.currentState!.validate()) {
                      try {
                        final user = await _auth
                            .signInWithEmailAndPassword(
                                email: _email.toString(),
                                password: _password.toString())
                            .then((value) async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString('email', _email!);
                          print('my email is $_email');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TasksScreen()),
                          );
                        });

                        // if (user != null) {
                        //   // Navigator.pushNamed(context, ChatScreen.id);
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => TasksScreen()),
                        //   );
                        // }
                      } catch (e) {
                        _showErrorFailure();

                        print(e);
                      }

                      // you can add your statements here
                      // showSnackBar(context,
                      //     "Password does not match. Please re-type again.");
                    } else {
                      print("validation nt true");
                    }
                  },
                ),
              ),
              // Row(
              //   children: [
              //     TextButton(
              //       child: Text(
              //         "Login",
              //         style: TextStyle(fontSize: 25),
              //       ),
              //       onPressed: () async {
              //         print('${_email}, ${_password}');
              //         try {
              //           final user = await _auth.signInWithEmailAndPassword(
              //               email: _email, password: _password);
              //           if (user != null) {
              //             // Navigator.pushNamed(context, ChatScreen.id);
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => TasksScreen()),
              //             );
              //           }
              //         } catch (e) {
              //           _showErrorFailure();

              //           print(e);
              //         }
              //       },
              //     ),
              //     TextButton(
              //       child: Text(
              //         "forget password",
              //         style: TextStyle(fontSize: 25),
              //       ),
              //       onPressed: () {
              //         // Navigator.push(
              //         //   context,
              //         //   MaterialPageRoute(
              //         //       builder: (context) => const resetpassword()),
              //         // );
              //       },
              //     ),
              //   ],
              // ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const registrationpage()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "sign up",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              InkWell(
                onTap: () async {
                  print(_email);
                  try {
                    await _auth.sendPasswordResetEmail(
                        email: _email.toString());
                    print("sucessful");
                    _showresetpasswordsucess();
                  } catch (e) {
                    print(e);
                    print("nt sucessful");
                    _showresetpasswordFailure();
                  }

                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const registrationpage()),
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Forget  your password?",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
