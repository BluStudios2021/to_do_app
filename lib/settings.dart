import 'package:flutter/material.dart';
import 'theme.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with TickerProviderStateMixin {
  final List<Color> primaryColors = [
    Colors.deepOrange[500]!,
    Colors.red[500]!,
    Colors.pink[500]!,
    Colors.purple[500]!,
    Colors.deepPurple[500]!,
    Colors.indigo[500]!,
    Colors.blue[500]!,
    Colors.lightBlue[500]!,
    Colors.cyan[500]!,
    Colors.teal[500]!,
    Colors.green[800]!,
    Colors.green[500]!,
    Colors.lightGreen[500]!,
    Colors.lime[500]!,
    Colors.yellow[500]!,
    Colors.amber[500]!,
    Colors.orange[500]!,
    Colors.brown[500]!,
    Colors.grey[500]!,
    Colors.blueGrey[500]!,
  ];

  final List<Color> secondaryColors = [
    Colors.deepOrange[300]!,
    Colors.red[300]!,
    Colors.pink[300]!,
    Colors.purple[300]!,
    Colors.deepPurple[300]!,
    Colors.indigo[300]!,
    Colors.blue[300]!,
    Colors.lightBlue[300]!,
    Colors.cyan[300]!,
    Colors.teal[300]!,
    Colors.green[600]!,
    Colors.green[300]!,
    Colors.lightGreen[300]!,
    Colors.lime[300]!,
    Colors.yellow[300]!,
    Colors.amber[300]!,
    Colors.orange[300]!,
    Colors.brown[300]!,
    Colors.grey[300]!,
    Colors.blueGrey[300]!,
  ];

  Color primaryColor = CustomTheme.primary();
  Color prevPrimaryColor = CustomTheme.primary();
  Color secondaryColor = CustomTheme.secondary();

  Color checkBoxColor = CustomTheme.checkBox();
  Color prevCheckBoxColor = CustomTheme.checkBox();
  Color checkColor = CustomTheme.check();

  int expanded = 0;

  late AnimationController controllerPrimary;
  late AnimationController controllerCheckBox;

  @override
  void initState() {
    controllerPrimary = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    controllerCheckBox = AnimationController(
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
          animation: controllerPrimary,
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
                  begin: prevPrimaryColor,
                  end: primaryColor,
                ).evaluate(controllerPrimary),
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
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 8.0,
              top: 8.0,
              right: 8.0,
            ),
            decoration: BoxDecoration(
              color: CustomTheme.taskBox(),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 200),
              reverseDuration: const Duration(milliseconds: 200),
              alignment: Alignment.topRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      top: 6.0,
                      right: 12.0,
                      bottom: 6.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        if (expanded == 1) {
                          setState(() {
                            expanded = 0;
                            prevPrimaryColor = primaryColor;
                            primaryColor = CustomTheme.primary();
                            controllerPrimary.reset();
                            controllerPrimary.forward();
                          });
                        } else {
                          setState(() {
                            expanded = 1;
                            // check color = CustomTheme.checkColor
                          });
                        }
                      },
                      child: AnimatedBuilder(
                        animation: controllerPrimary,
                        builder: (context, child) {
                          return Text(
                            'Primary color',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              color: ColorTween(
                                begin: prevPrimaryColor,
                                end: primaryColor,
                              ).evaluate(controllerPrimary),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  (expanded != 1)
                      ? const SizedBox()
                      : GridView(
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
                                    prevPrimaryColor = primaryColor;
                                    primaryColor = primaryColors[i];
                                    secondaryColor = secondaryColors[i];
                                  });
                                  controllerPrimary.reset();
                                  await controllerPrimary.forward();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: primaryColors[i],
                                    shape: BoxShape.circle,
                                  ),
                                  child: (primaryColors.indexOf(primaryColor) == i)
                                      ? const FittedBox(
                                          child: Icon(
                                            Icons.check_rounded,
                                          ),
                                        )
                                      : const SizedBox(),
                                ),
                              )
                          ],
                        ),
                  (expanded != 1)
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(
                            right: 12.0,
                            bottom: 2.0,
                          ),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                CustomTheme.setPrimary(primaryColor);
                                CustomTheme.setSecondary(secondaryColor);
                                expanded = 0;
                              });
                            },
                            child: AnimatedBuilder(
                              animation: controllerPrimary,
                              builder: (context, child) {
                                return Text(
                                  'Done',
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: ColorTween(
                                      begin: prevPrimaryColor,
                                      end: primaryColor,
                                    ).evaluate(controllerPrimary),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 8.0,
              top: 8.0,
              right: 8.0,
            ),
            decoration: BoxDecoration(
              color: CustomTheme.taskBox(),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 200),
              reverseDuration: const Duration(milliseconds: 200),
              alignment: Alignment.topRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      top: 6.0,
                      right: 12.0,
                      bottom: 6.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        if (expanded == 2) {
                          setState(() {
                            expanded = 0;
                            prevCheckBoxColor = checkBoxColor;
                            checkBoxColor = CustomTheme.checkBox();
                            controllerCheckBox.reset();
                            controllerCheckBox.forward();
                          });
                        } else {
                          setState(() {
                            expanded = 2;
                            // check color = CustomTheme.checkColor
                          });
                        }
                      },
                      child: AnimatedBuilder(
                        animation: controllerCheckBox,
                        builder: (context, child) {
                          return Text(
                            'Checkbox color',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              color: ColorTween(
                                begin: prevCheckBoxColor,
                                end: checkBoxColor,
                              ).evaluate(controllerCheckBox),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  (expanded != 2)
                      ? const SizedBox()
                      : GridView(
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
                                    prevCheckBoxColor = checkBoxColor;
                                    checkBoxColor = primaryColors[i];
                                    secondaryColor = secondaryColors[i];
                                  });
                                  controllerCheckBox.reset();
                                  await controllerCheckBox.forward();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: primaryColors[i],
                                    shape: BoxShape.circle,
                                  ),
                                  child: (primaryColors.indexOf(checkBoxColor) == i)
                                      ? const FittedBox(
                                          child: Icon(
                                            Icons.check_rounded,
                                          ),
                                        )
                                      : const SizedBox(),
                                ),
                              )
                          ],
                        ),
                  (expanded != 2)
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(
                            right: 12.0,
                            bottom: 2.0,
                          ),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                CustomTheme.setCheckBox(checkBoxColor);
                                expanded = 0;
                              });
                            },
                            child: AnimatedBuilder(
                              animation: controllerCheckBox,
                              builder: (context, child) {
                                return Text(
                                  'Done',
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: ColorTween(
                                      begin: prevCheckBoxColor,
                                      end: checkBoxColor,
                                    ).evaluate(controllerCheckBox),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
