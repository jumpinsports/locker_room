import 'package:flutter/material.dart';

class TitleAppBar extends StatelessWidget with PreferredSizeWidget {
  const TitleAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Image.asset(
          'images/JumpInLogo-nologo.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}