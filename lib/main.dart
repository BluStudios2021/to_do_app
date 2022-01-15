import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/model/task.dart';
import 'package:to_do_app/model/task_new.dart';
import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskNewAdapter());
  Hive.registerAdapter(ColorAdapter());
  await Hive.openBox<Task>('tasks');
  await Hive.openBox<TaskNew>('tasks_new');
  await Hive.openBox<Color>('colors');

  if (Hive.box<Task>('tasks').isNotEmpty) {
    for (int i = 0; i < Hive.box<Task>('tasks').length; i++) {
      Task task = Hive.box<Task>('tasks').getAt(i)!;
      Hive.box<TaskNew>('tasks_new').add(
        TaskNew()
          ..checked = task.checked
          ..header = task.header
          ..body = task.body
          ..marked = false,
      );
    }
    Hive.box<Task>('tasks').clear();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var createNew = false;

  var currentIndex = 0;

  @override
  void dispose() {
    Hive.box('tasks').close();
    Hive.box('colors').close();
    Hive.box('tasks_new').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
