import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';

class DarkButton extends StatelessWidget {
  const DarkButton({
    super.key, required this.function, required this.title,
  });

  final void Function() function;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: kMainDarkColor,
            borderRadius: BorderRadius.circular(16.0)),
        child: Text(title, style: kTextAccent28),
      ),
    );
  }
}