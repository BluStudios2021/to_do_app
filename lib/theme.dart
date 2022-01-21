import 'package:flutter/material.dart';
import 'boxes.dart';

class CustomTheme {
  static setPrimary(Color color) {
    Boxes.getColors().put('primary', color);
  }

  static setSecondary(Color color) {
    Boxes.getColors().put('secondary', color);
  }

  static setCheckBox(Color color) {
    Boxes.getColors().put('check_box', color);
  }

  static setCheck(Color color) {
    Boxes.getColors().put('check', color);
  }

  static Color primary() {
    Color? color = Boxes.getColors().get('primary');
    color ??= Colors.amber;
    return color;
  }

  static Color secondary() {
    Color? color = Boxes.getColors().get('secondary');
    color ??= Colors.amber[300]!;
    return color;
  }

  static Color background() {
    return Colors.grey[900]!;
  }

  static Color textAppBar() {
    return const Color(0xFF101010);
  }

  static Color textPrimaryStrong() {
    return Colors.grey[300]!;
  }

  static Color textPrimaryNormal() {
    return Colors.grey[500]!;
  }

  static Color textPrimaryImportant() {
    return Colors.red[400]!;
  }

  static Color textSecondaryStrong() {
    return Colors.grey[400]!;
  }

  static Color textSecondaryNormal() {
    return Colors.grey[600]!;
  }

  static Color taskBox() {
    return const Color(0xFF303030);
  }

  static Color checkBox() {
    Color? color = Boxes.getColors().get('check_box');
    color ??= Colors.green[500]!;
    return color;
  }

  static Color check() {
    Color? color = Boxes.getColors().get('check');
    color ??= Colors.green[500]!;
    return color;
  }
}
