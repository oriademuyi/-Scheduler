import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:muyi_todo/screens/authentication/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:file_picker/file_picker.dart';

final _firstore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;

class registrationpage extends StatefulWidget {
  const registrationpage({Key? key}) : super(key: key);

  @override
  State<registrationpage> createState() => _registrationpageState();
}

class _registrationpageState extends State<registrationpage> {
  String? _email;
  String? _password;
  String? _fullNmae;
  String? _confirmPassword;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  bool _isObscure = true;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        // uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        // uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_email.toString());
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
      print("its sucessful jare");
    } catch (e) {
      print(' ther big issue error occured  which is $e');
    }
  }

  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
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
                      "Create an account to save and plan  all your schedules and access them anywhere",
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
                  validator: (value) {
                    _fullNmae = value;
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    if (value.trim().length < 3) {
                      return 'Name must be at least 3 characters in length';
                    }
                    // Return null if the entered password is valid
                    return null;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    hintText: 'Enter your full name',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide.none),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _fullNmae = value.trim();
                    });
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: TextFormField(
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@') ||
                        !value.contains('.')) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    hintText: 'Enter your Email',
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

              Column(
                children: <Widget>[
                  SizedBox(
                    height: 32,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Color(0xffFDCF09),
                        child: _photo != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  _photo!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50)),
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey[800],
                                ),
                              ),
                      ),
                    ),
                  )
                ],
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
                    hintText: ' Enter password',
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
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: TextFormField(
                  obscureText: _isObscure,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please Re-Enter New Password";
                    } else if (value.trim().length < 8) {
                      return "Password must be atleast 8 characters long";
                    } else if (value != _password) {
                      return "Password must be same as above";
                    } else {
                      return null;
                    }
                  },
                  // validator: (value) {
                  //   if (value == null || value.trim().isEmpty) {
                  //     return 'This field is required';
                  //   }
                  //   if (value.trim().length < 8) {
                  //     return 'Password must be at least 8 characters in length';
                  //   }
                  //   // Return null if the entered password is valid
                  //   return null;
                  // },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    hintText: ' Confirm password',
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
                      _confirmPassword = value.trim();
                    });
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),

              SizedBox(
                width: 340,
                child: Text(
                  "By selecting Agree and Continue below i agree to ${'Terms of Service and Privacy Policy'}",
                  style: TextStyle(fontSize: 12, height: 1.5),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: EdgeInsets.only(left: 80, right: 80),
                child: TextButton(
                  child: Text(
                    'Agree and Continue',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () async {
                    print('${_email}, ${_password}');
                    if (_password == _confirmPassword &&
                        _formKey.currentState!.validate()) {
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: _email.toString(),
                                password: _password.toString());

                        if (newUser != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const loginPage()),
                          );
                        }
                        try {
                          _firstore.collection('todousers').add({
                            'fullname': _fullNmae,
                            'useremail': _email,
                          });
                          uploadFile();
                        } catch (e) {
                          print(e);
                        }
                      } catch (e) {
                        // _showErrorFailure();
                        print(e);
                      }

                      // you can add your statements here
                      // showSnackBar(context,
                      //     "Password does not match. Please re-type again.");
                    } else {
                      print("password and confirm password is not the same");
                    }
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const loginPage()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already  have an account?"),
                        SizedBox(
                          width: 10,
                        ),
                        Text("sign in",
                            style: TextStyle(
                              color: Colors.grey,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              // Row(
              //   children: [
              //     TextButton(
              //       child: Text(
              //         "Reg",
              //         style: TextStyle(fontSize: 25),
              //       ),
              //       onPressed: () async {
              //         print('${_email}, ${_password}');
              //         try {
              //           final newUser = await _auth.createUserWithEmailAndPassword(
              //               email: _email, password: _password);
              //           if (newUser != null) {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => const loginPage()),
              //             );
              //           }
              //         } catch (e) {
              //           // _showErrorFailure();
              //           print(e);
              //         }
              //         // Authentication.signin(context, _email, _password);
              //       },
              //     ),
              //     TextButton(
              //       child: Text(
              //         "already have an account",
              //         style: TextStyle(fontSize: 25),
              //       ),
              //       onPressed: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(builder: (context) => const loginPage()),
              //         );
              //       },
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ]),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
