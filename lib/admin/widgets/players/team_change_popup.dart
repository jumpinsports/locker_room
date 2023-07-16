import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';
import '../../../data/firebase_repository.dart';
import '../../../data/player.dart';
import '../../../data/providers.dart';

class TeamChangePopup extends ConsumerWidget {
  const TeamChangePopup({super.key, required this.player});

  final Player player;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestoreRepository = ref.watch(firestoreRepositoryProvider);
    final playerId = ref.watch(playerIdProvider);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FirestoreListView(
              query: firestoreRepository.teamsQuery(),
              shrinkWrap: true,
              itemBuilder: (context, doc) {
                final newTeam = doc.data();
                final newTeamId = doc.id;

                /// Returns an inkwell for each team on the list
                return InkWell(
                  onTap: () {
                    /// Change team name in firestore
                    firestoreRepository.changePlayerTeam(
                      playerId,
                      player.teams[0],
                      newTeamId,
                    );
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(32),
                  splashColor: kMainAccentColor,
                  highlightColor: kMainLightColor,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(32),
                      ),
                    ),
                    child: Text(
                      newTeam.name,
                      style: kTextDark28,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
