import 'package:flutter/material.dart';
import 'package:locker_room/constants/text_styles.dart';

import '../constants/app_sizes.dart';
import 'widgets/admin_main_button.dart';
import '../widgets/home_scaffold.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
      backNav: '/home',
      body: Column(
        children: [
          Text('Admin View', style: kTextDark36),
          gapH16,
          const AdminMainButton(title: 'Players', link: '/home/admin/player'),
          gapH16,
          const AdminMainButton(title: 'Teams', link: '/home/admin/team'),
          gapH16,
          const AdminMainButton(title: 'Games', link: '/home/admin/game'),
        ],
      ),
    );
  }
}
