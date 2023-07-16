import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';

class AdminMainButton extends StatelessWidget {
  const AdminMainButton({
    super.key, required this.title, required this.link,
  });

  final String title;
  final String link;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(link),
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: kMainDarkColor,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: kRTextAccent64,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
