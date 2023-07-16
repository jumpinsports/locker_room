import 'package:flutter/material.dart';
import 'package:locker_room/widgets/home_scaffold.dart';

class AdminGameScreen extends StatelessWidget {
  const AdminGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
      backNav: '/home/admin',
      body: Column(
        children: [],
      ),
    );
  }
}
