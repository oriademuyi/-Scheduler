import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:muyi_todo/models/task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(name: "buy rice"),
    Task(name: "buy beans"),
    Task(name: "buy bread"),
  ];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskTittle) {
    final task = Task(name: newTaskTittle);
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
  }

  void deletTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
