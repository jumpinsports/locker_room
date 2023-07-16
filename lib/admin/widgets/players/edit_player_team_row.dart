import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locker_room/admin/widgets/players/team_change_popup.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';
import '../../../data/firebase_repository.dart';
import '../../../data/player.dart';

class EditPlayerTeamRow extends ConsumerWidget {
  const EditPlayerTeamRow({
    super.key,
    required this.player,
  });

  final Player player;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestoreRepository = ref.watch(firestoreRepositoryProvider);
    Future<String> currentTeamName =
        firestoreRepository.teamName(player.teams[0]);

    return FutureBuilder(
      future: currentTeamName,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return TeamNameRow(teamLine: snapshot.data, player: player);
        } else if (!snapshot.hasData) {
          return TeamNameRow(teamLine: 'No team assigned', player: player);
        } else if (snapshot.hasError) {
          return const Icon(Icons.error_outline);
        } else {
          return const LinearProgressIndicator();
        }
      },
    );
  }
}

class TeamNameRow extends ConsumerWidget {
  const TeamNameRow({
    super.key, required this.teamLine, required this.player,
  });

  final String teamLine;
  final Player player;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Text(teamLine, style: kTextDark20),
        const Spacer(),
        GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) => TeamChangePopup(player: player),
          ),
          child: const Icon(
            Icons.edit,
            size: 20,
            color: kMainDarkColor,
          ),
        ),
      ],
    );
  }
}
