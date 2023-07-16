import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locker_room/constants/colors.dart';
import 'package:locker_room/constants/text_styles.dart';

import '../constants/app_sizes.dart';

class TitleAppBar extends StatelessWidget with PreferredSizeWidget {
  const TitleAppBar({Key? key, required this.backNav}) : super(key: key);

  final String backNav;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 120,
      flexibleSpace: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          backNav != ''
              ? GestureDetector(
                  onTap: () => context.go(backNav),
                  child: const Icon(Icons.arrow_back_ios,
                      color: kMainLightColor, size: 32))
              : Container(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/JumpInLogo-nologo.png',
                height: 35,
              ),
              gapH12,
              Text('Locker Room', style: kRTextLight28),
              // GestureDetector(
              //   onTap: () => context.go('/home/profile'),
              //   child: const Icon(Icons.person, size: 28, color: kMainLightColor),
              // ),
            ],
          ),
          GestureDetector(
            onTap: () => context.go('/home/profile'),
            child: const Icon(Icons.person, size: 32, color: kMainLightColor),
          ),

          /// FOR TESTING ONLY
          GestureDetector(
            onTap: () => context.go('/home/admin'),
            child: const Icon(Icons.settings, size: 32, color: kMainLightColor),
          ),
        ],
      ),
      // leading: Padding(
      //   padding: const EdgeInsets.only(left: 8.0),
      //   child: Image.asset(
      //     'images/JumpInLogo-nologo.png',
      //     fit: BoxFit.fitWidth,
      //   ),
      // ),
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.only(right: 8.0),
      //     child: GestureDetector(
      //       onTap: () => context.go('/home/profile'),
      //       child: const Icon(Icons.person, size: 28),
      //     ),
      //   )
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
