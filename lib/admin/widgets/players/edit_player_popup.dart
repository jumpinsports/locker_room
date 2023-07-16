import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locker_room/data/player.dart';

import '../../../constants/app_sizes.dart';
import '../../../data/providers.dart';
import 'edit_player_row.dart';
import 'edit_player_team_row.dart';

class EditPlayerPopup extends ConsumerWidget {
  const EditPlayerPopup(
      {super.key, required this.player, required this.playerId});

  final Player player;
  final String playerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        ref.read(playerIdProvider.notifier).state = playerId;
        showModalBottomSheet(
          context: context,
          builder: (context) => SizedBox(
            height: height * .50,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  EditPlayerRow(
                      player: player, item: 'first'),
                  gapH20,
                  EditPlayerRow(
                      player: player, item: 'last'),
                  gapH20,
                  EditPlayerRow(
                      player: player, item: 'email'),
                  gapH20,
                  EditPlayerTeamRow(player: player),
                  gapH32,
                  const Text(
                    'If you change the email address remember to create a new login info in Firebase and link it to their account',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: const Icon(Icons.edit, size: 24),
    );
  }
}
