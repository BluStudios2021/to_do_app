import 'package:flutter/material.dart';
import 'theme.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with SingleTickerProviderStateMixin {
  Color currentColor = CustomTheme.primary();
  Color previousColor = CustomTheme.primary();

  List<Color> colors = [
    Colors.deepOrange,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green[800]!,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
  ];

  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.background(),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 50),
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Container(
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
                color: ColorTween(
                  begin: previousColor,
                  end: currentColor,
                ).evaluate(controller),
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
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: CustomTheme.textAppBar(),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Settings',
                      style: TextStyle(color: CustomTheme.textAppBar(), fontSize: 36, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: CustomTheme.boxTask(),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            GridView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              padding: const EdgeInsets.only(
                left: 16.0,
                top: 16.0,
                right: 16.0,
                bottom: 12.0,
              ),
              children: [
                for (int i = 0; i < 20; i++)
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        previousColor = currentColor;
                        currentColor = colors[i];
                      });
                      controller.reset();
                      await controller.forward();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: colors[i],
                        shape: BoxShape.circle,
                      ),
                      child: (colors.indexOf(currentColor) == i)
                          ? const FittedBox(
                              child: Icon(
                                Icons.check_rounded,
                              ),
                            )
                          : null,
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 12.0,
                bottom: 2.0,
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    CustomTheme.setPrimary(currentColor);
                  });
                  Navigator.pop(context);
                },
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 32,
                        color: ColorTween(
                          begin: previousColor,
                          end: currentColor,
                        ).evaluate(controller),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
