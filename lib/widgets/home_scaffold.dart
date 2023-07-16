import 'package:flutter/material.dart';
import 'package:locker_room/widgets/title_app_bar.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({
    super.key, required this.backNav, required this.body,
  });

  final String backNav;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TitleAppBar(backNav: backNav),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: body
          ),
        ),
      ),
    );
  }
}

