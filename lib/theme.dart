import 'package:flutter/material.dart';
import 'boxes.dart';

class CustomTheme {
  static Color primary() {
    Color? color = Boxes.getColors().get('primary');
    color ??= Colors.amber;
    return color;
  }

  static setPrimary(Color color) {
    Boxes.getColors().put('primary', color);
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

  static Color boxTask() {
    return const Color(0xFF303030);
  }
}
