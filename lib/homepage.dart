import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'theme.dart';
import 'settings.dart';
import 'task_view.dart';
import 'edit_task.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.background(),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 50),
        child: OpenContainer(
          tappable: false,
          transitionDuration: const Duration(milliseconds: 600),
          transitionType: ContainerTransitionType.fade,
          openColor: CustomTheme.background(),
          openShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
          openElevation: 0.0,
          closedColor: CustomTheme.background(),
          closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
          closedElevation: 0.0,
          onClosed: (value) => setState(() {}),
          openBuilder: (context, _) => Settings(),
          closedBuilder: (context, openContainer) => Container(
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
                Expanded(
                  child: Text(
                    'To Do List',
                    style: TextStyle(
                      color: CustomTheme.textAppBar(),
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  iconSize: 32,
                  padding: const EdgeInsets.all(0.0),
                  alignment: Alignment.centerRight,
                  splashRadius: 0.1,
                  onPressed: () {
                    openContainer();
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
      ),
      floatingActionButton: OpenContainer(
        transitionDuration: const Duration(milliseconds: 600),
        transitionType: ContainerTransitionType.fade,
        openColor: CustomTheme.boxTask(),
        openShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
        openElevation: 0.0,
        closedColor: CustomTheme.primary(),
        closedShape: const CircleBorder(),
        closedElevation: 0.0,
        openBuilder: (context, _) => const EditTask(index: 0),
        closedBuilder: (context, openContainer) => FloatingActionButton(
          onPressed: () {
            openContainer();
          },
          backgroundColor: CustomTheme.primary(),
          foregroundColor: CustomTheme.textAppBar(),
          child: const Icon(
            Icons.add_rounded,
            size: 48,
          ),
        ),
      ),
      body: TaskView(),
    );
  }
}
