import 'dart:io';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'fade_animation.dart';
import 'edit_task.dart';
import 'model/task_new.dart';
import 'theme.dart';
import 'boxes.dart';

class TaskView extends StatefulWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  int showExpanded = 0;
  TaskNew? recentlyRemoved;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: ReorderableListView(
        key: UniqueKey(),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        onReorder: (oldIndex, newIndex) {
          if (showExpanded == 0) {
            null;
          } else if (showExpanded - 1 == oldIndex) {
            if (newIndex < oldIndex) {
              showExpanded = newIndex + 1;
            } else {
              showExpanded = newIndex;
            }
          } else if (showExpanded - 1 >= newIndex && showExpanded - 1 < oldIndex) {
            showExpanded += 1;
          } else if (showExpanded - 1 < newIndex && showExpanded - 1 > oldIndex) {
            showExpanded -= 1;
          } else {
            showExpanded = showExpanded;
          }

          TaskNew mTask = Boxes.getTasks().getAt(oldIndex)!;
          Boxes.getTasks().deleteAt(oldIndex);

          if (newIndex <= Boxes.getTasks().length) {
            List<TaskNew> tasks = List.empty(growable: true);

            for (int i = 0; i < Boxes.getTasks().length; i++) {
              if (i == newIndex - ((oldIndex <= newIndex) ? 1 : 0)) {
                tasks.add(mTask);
              }
              tasks.add(Boxes.getTasks().getAt(i)!);
            }

            Boxes.getTasks().deleteAll(Boxes.getTasks().keys);

            for (TaskNew task in tasks) {
              setState(() {
                Boxes.getTasks().add(task);
              });
            }
          } else {
            setState(() {
              Boxes.getTasks().add(mTask);
            });
          }
        },
        children: [
          for (int index = 0; index < Boxes.getTasks().length; index++)
            Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                recentlyRemoved = Boxes.getTasks().getAt(index);
                setState(() {
                  Boxes.getTasks().deleteAt(index);
                });

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: const Duration(seconds: 3),
                    backgroundColor: CustomTheme.background(),
                    elevation: 0.0,
                    dismissDirection: DismissDirection.startToEnd,
                    padding: const EdgeInsets.all(8.0),
                    content: FadeAnimation(
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          top: 12.0,
                          right: 16.0,
                          bottom: 12.0,
                        ),
                        decoration: BoxDecoration(
                          color: CustomTheme.boxTask(),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(recentlyRemoved!.header + ' got removed!',
                                style: const TextStyle(
                                  fontSize: 18,
                                )),
                            InkWell(
                              customBorder: const RoundedRectangleBorder(),
                              onTap: () {
                                setState(() {
                                  if (recentlyRemoved != null) {
                                    Boxes.getTasks().add(recentlyRemoved!);
                                  }
                                  recentlyRemoved = null;
                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                });
                              },
                              child: Text(
                                'UNDO',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: CustomTheme.primary(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )));
              },
              child: AnimatedSize(
                duration: const Duration(milliseconds: 600),
                child: Container(
                  key: UniqueKey(),
                  margin: const EdgeInsets.only(
                    left: 6.0,
                    top: 8.0,
                    right: 6.0,
                  ),
                  child: OpenContainer(
                    tappable: false,
                    transitionDuration: const Duration(milliseconds: 600),
                    transitionType: ContainerTransitionType.fade,
                    openColor: CustomTheme.boxTask(),
                    openShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    openElevation: 0.0,
                    closedColor: CustomTheme.boxTask(),
                    closedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    closedElevation: 0.0,
                    openBuilder: (context, _) => EditTask(index: index + 1),
                    closedBuilder: (context, VoidCallback openContainer) => Container(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: SizedBox(
                                  width: 42,
                                  height: 42,
                                  child: Transform.scale(
                                    scale: 1.25,
                                    child: Checkbox(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      value: Boxes.getTasks().getAt(index)!.checked,
                                      activeColor: Colors.green,
                                      onChanged: (val) {
                                        setState(() {
                                          Boxes.getTasks().getAt(index)!.checked = val!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    if (showExpanded == index + 1) {
                                      setState(() {
                                        showExpanded = 0;
                                      });
                                    } else if (Boxes.getTasks().getAt(index)!.body != '') {
                                      setState(() {
                                        showExpanded = index + 1;
                                      });
                                    }
                                  },
                                  onDoubleTap: () {
                                    setState(() {
                                      Boxes.getTasks().getAt(index)!.marked = !Boxes.getTasks().getAt(index)!.marked;
                                    });
                                  },
                                  child: Text(
                                    Boxes.getTasks().getAt(index)!.header,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: (Boxes.getTasks().getAt(index)!.checked)
                                          ? CustomTheme.textPrimaryNormal()
                                          : (Boxes.getTasks().getAt(index)!.marked)
                                              ? CustomTheme.primary()
                                              : CustomTheme.textPrimaryStrong(),
                                      decoration:
                                          (Boxes.getTasks().getAt(index)!.checked) ? TextDecoration.lineThrough : null,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 42,
                                height: 42,
                                child: IconButton(
                                  splashRadius: 24,
                                  onPressed: () => openContainer(),
                                  icon: Icon(
                                    Icons.edit_rounded,
                                    color: CustomTheme.textPrimaryNormal(),
                                  ),
                                ),
                              ),
                              Container(
                                width: (Platform.isAndroid || Platform.isIOS) ? 0 : 32,
                              ),
                            ],
                          ),
                          (showExpanded == index + 1)
                              ? Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 8.0,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showExpanded = 0;
                                      });
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 32,
                                        ),
                                        Expanded(
                                          child: Text(
                                            (Boxes.getTasks().getAt(index)!.body == '')
                                                ? ''
                                                : Boxes.getTasks().getAt(index)!.body,
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: (Boxes.getTasks().getAt(index)!.checked)
                                                  ? CustomTheme.textSecondaryNormal()
                                                  : CustomTheme.textSecondaryStrong(),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 24,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
