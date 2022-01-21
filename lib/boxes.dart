import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/model/task_new.dart';

class Boxes {
  static Box<TaskNew> getTasks() {
    return Hive.box<TaskNew>('tasks_new');
  }

  static Box<Color> getColors() {
    return Hive.box<Color>('colors');
  }
}
