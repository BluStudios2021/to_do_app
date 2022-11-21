import 'package:flutter/material.dart';
import 'model/task_new.dart';
import 'boxes.dart';
import 'theme.dart';
import 'settings.dart';

class EditTask extends StatefulWidget {
  const EditTask({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  _EditTaskState createState() => _EditTaskState(index: index);
}

class _EditTaskState extends State<EditTask> {
  _EditTaskState({required this.index});

  final int index;

  var controllerHeader = TextEditingController();
  var controllerBody = TextEditingController();

  FocusNode firstFocusNode = FocusNode();
  FocusNode secondFocusNode = FocusNode();

  @override
  void initState() {
    if (index == 0) {
      controllerHeader.text = '';
      controllerBody.text = '';
    } else {
      controllerHeader.text = Boxes.getTasks().getAt(index - 1)!.header;
      controllerBody.text = Boxes.getTasks().getAt(index - 1)!.body;
    }
    if (index == 0) {
      Future.delayed(const Duration(milliseconds: 200), () {
        FocusScope.of(context).requestFocus(firstFocusNode);
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerHeader.dispose();
    controllerBody.dispose();
    super.dispose();
  }

  addTask(bool checked, String header, String body, bool marked) {
    if (header != '') {
      final task = TaskNew()
        ..checked = checked
        ..header = header
        ..body = body
        ..marked = marked;

      if (index == 0) {
        setState(() {
          List<TaskNew> tasks = List.empty(growable: true);

          tasks.add(task);

          for (int i = 0; i < Boxes.getTasks().length; i++) {
            tasks.add(Boxes.getTasks().getAt(i)!);
          }

          Boxes.getTasks().deleteAll(Boxes.getTasks().keys);

          for (TaskNew t in tasks) {
            Boxes.getTasks().add(t);
          }
        });
      } else {
        setState(() {
          Boxes.getTasks().putAt(index - 1, task);
        });
      }
      exit();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        elevation: 12.0,
        content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text('Must have a title!',
                  style: TextStyle(
                    fontSize: 18,
                  )),
            ]),
      ));
    }
  }

  Future<void> exit() async {
    FocusManager.instance.primaryFocus?.unfocus();
    await Future.delayed(const Duration(milliseconds: 200));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.background(),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 50),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 4.0,
            left: 16.0,
            right: 16.0,
            bottom: 4.0,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
            color: CustomTheme.primary(),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                iconSize: 32,
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.centerLeft,
                splashRadius: 0.1,
                onPressed: () {
                  exit();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: CustomTheme.textAppBar(),
                ),
              ),
              Expanded(
                child: Text(
                  'Edit Task',
                  style: TextStyle(color: CustomTheme.textAppBar(), fontSize: 36, fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(
                iconSize: 32,
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.centerRight,
                splashRadius: 0.1,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Settings(),
                      )).then((value) => setState(() {}));
                },
                icon: Icon(
                  Icons.settings_rounded,
                  color: CustomTheme.textAppBar(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: CustomTheme.taskBox(),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.only(
          left: 12.0,
          right: 12.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              cursorColor: CustomTheme.primary(),
              focusNode: firstFocusNode,
              onSubmitted: (String value) {
                if (index == 0) {
                  FocusScope.of(context).requestFocus(secondFocusNode);
                } else {
                  FocusScope.of(context).unfocus();
                }
              },
              maxLines: 1,
              controller: controllerHeader,
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(
                  color: CustomTheme.textPrimaryNormal(),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: CustomTheme.primary()),
                ),
              ),
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w600,
                color: CustomTheme.textPrimaryStrong(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                ),
                child: TextField(
                  cursorColor: CustomTheme.primary(),
                  focusNode: secondFocusNode,
                  maxLines: 99999,
                  controller: controllerBody,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    hintStyle: TextStyle(
                      color: CustomTheme.textSecondaryNormal(),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: CustomTheme.primary()),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 26,
                    color: CustomTheme.textSecondaryStrong(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: TextButton(
                onPressed: () {
                  addTask(
                    (index > 0) ? Boxes.getTasks().getAt(index - 1)!.checked : false,
                    controllerHeader.text.toString(),
                    controllerBody.text.toString(),
                    (index > 0) ? Boxes.getTasks().getAt(index - 1)!.marked : false,
                  );
                },
                child: Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 32,
                    color: CustomTheme.primary(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
