import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muyi_todo/models/task.dart';
import 'package:muyi_todo/screens/widgets/task_tile.dart';
import 'package:provider/provider.dart';
import 'package:muyi_todo/models/task_date.dart';

final _firstore = FirebaseFirestore.instance;
final docRef = _firstore.collection("todolist").doc("todo");
final docRefB = _firstore.collection("todolist");
final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;

bool checkbox = false;
// final delete = _firstore.collection("todolist").doc("todo").id;
// Remove the 'capital' field from the document
final updates = <String, dynamic>{
  "todolist": FieldValue.delete(),
};

class taskList extends StatefulWidget {
  @override
  State<taskList> createState() => _taskListState();
}

class _taskListState extends State<taskList> {
  // void getTodoInfor() async {
  //   final todoinfo = await _firstore.collection("todolist").get();
  //   for (var todoinfo in todoinfo.docs) {
  //     print(todoinfo.data());
  //   }
  // }
  void getTodoInfostream() async {
    await for (var snapshot in _firstore.collection("todolist").snapshots()) {
      for (var todoinfo in snapshot.docs) {
        print(todoinfo.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firstore
            .collection('todolist')
            .where("uid", isEqualTo: user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent),
            );
          }

          final messages = snapshot.data!.docs;
          final messagelentght = messages.length;
          //  final messages= snapshot.data!.docs;
          List<MessageBubble> messageBubles = [];
          for (var message in messages) {
            var data = message.data() as Map;

            // add Typecast
            // final messageText = data['todo'];
            final todotext = data['todo'];

            final messageBuble = MessageBubble(
              sender: todotext,
              onPressed: () {
                print(message.id);
                delectdoc(todoId: message.id);
                // docRef.update(updates);
              },
              checkboxchnage: Checkbox(
                activeColor: Colors.lightBlueAccent,
                value: checkbox,
                onChanged: (po) {
                  setState(() {
                    print(message.id);
                    checkbox = po!;
                  });
                },
              ),
              // text: messageText,
              // isme: currentUser == messageSender,
            );

            messageBubles.add(messageBuble); // you have to add item to list
          }
          return ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              children: messageBubles // your list should assign to children
              );
        });
    // my own sream bulider?
    // StreamBuilder<QuerySnapshot>(
    //     stream: _firstore.collection("todolist").snapshots(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         final todoinfo = snapshot.data!.docs;
    //         List<Text> todoinfowidgets = [];
    //         for (var todoinfo in todoinfo) {
    //           var data = todoinfo.data() as Map;
    //           final todotext = data['todo'];

    //           final todowidget = Text('$todotext');

    //           todoinfowidgets.add(todowidget);
    //         }
    //         return Column(children: todoinfowidgets);
    //       } else {
    //         return Container();
    //       }
    //     });

    //     Consumer<TaskData>(
    //   builder: (context, taskData, child) {
    //     return ListView.builder(
    //       itemBuilder: (context, index) {
    //         final task = taskData.tasks[index];
    //         return tasktile(
    //             tasktitle: task.name,
    //             isChecked: task.isDone,
    //             checkboxCallback: (bool? checkboxState) {
    //               // taskData.updateTask(task);
    //               setState(() {
    //                 taskData.updateTask(task);
    //               });
    //             },
    //             longpressCallback: () {
    //               // taskData.deletTask(task);
    //               // setState(() {
    //               // taskData.deletTask(task);
    //               // });
    //             });
    //       },
    //       itemCount: taskData.tasks.length,
    //     );
    //   },
    // );
  }
}

class MessageBubble extends StatefulWidget {
  MessageBubble({
    required this.sender,
    required this.onPressed,
    required this.checkboxchnage,
    //  this.text, this.isme
  });
  final String sender;
  final VoidCallback onPressed;
  final Checkbox checkboxchnage;

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  // final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: ListTile(
        leading: InkWell(
          onTap: widget.onPressed,
          child: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
        title: Text(widget.sender),
        trailing: widget.checkboxchnage,
      ),
    );
  }
}

void delectdoc({String? todoId}) {
  _firstore.collection("todolist").doc(todoId).delete().then((_) {
    print("delect succesful");
  });
}
