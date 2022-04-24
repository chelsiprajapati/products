import 'package:flutter/material.dart';

class AppTheme {
  Color get primaryColor => Color(0xff);

  List<BoxShadow> get cardBoxShadow => [
        BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            blurRadius: 4,
            spreadRadius: 4)
      ];

  BoxDecoration get cardDecoration => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: cardBoxShadow,
      );

  EdgeInsets get innerPadding => const EdgeInsets.all(16);
  EdgeInsets get outerPadding => const EdgeInsets.all(16);
}
