import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locker_room/admin/widgets/players/edit_player_popup.dart';
import 'package:locker_room/admin/widgets/email_button.dart';
import 'package:locker_room/constants/text_styles.dart';
import 'package:locker_room/data/player.dart';
import 'package:locker_room/widgets/home_scaffold.dart';

import '../constants/app_sizes.dart';
import '../data/firebase_repository.dart';

class AdminPlayerScreen extends ConsumerWidget {
  const AdminPlayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestoreRepository = ref.watch(firestoreRepositoryProvider);

    return HomeScaffold(
      backNav: '/home/admin',
      body: Column(
        children: [
          Text('Players', style: kTextDark36, textAlign: TextAlign.center),
          gapH16,
          FirestoreListView<Player>(
            shrinkWrap: true,
            query: firestoreRepository.playersQuery(),
            errorBuilder: (context, error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
            emptyBuilder: (context) => const Center(
              child: Text('no data'),
            ),
            itemBuilder:
                (BuildContext context, QueryDocumentSnapshot<Player> doc) {
              final player = doc.data();
              final teamName = firestoreRepository.teamName(player.teams.first);
              return ListTile(
                title: Text(
                  '${player.last}, ${player.first}',
                  style: kTextDark20,
                ),
                subtitle: TeamSubtitle(teamName: teamName),
                trailing: EditPlayerPopup(
                  player: player,
                  playerId: doc.id,
                ),
              );
            },
          ),
          gapH32,
          const EmailButton(),
        ],
      ),
    );
  }
}

class TeamSubtitle extends StatelessWidget {
  const TeamSubtitle({
    super.key,
    required this.teamName,
  });

  final Future<String> teamName;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: teamName,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data);
        } else if (!snapshot.hasData) {
          return const Text('No team assigned');
        } else if (snapshot.hasError) {
          return const Icon(Icons.error_outline);
        } else {
          return const LinearProgressIndicator();
        }
      },
    );
  }
}
