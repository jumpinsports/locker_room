import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locker_room/admin/widgets/teams/team_info_popup.dart';
import 'package:locker_room/data/team.dart';
import 'package:locker_room/widgets/home_scaffold.dart';

import '../constants/app_sizes.dart';
import '../constants/text_styles.dart';
import '../data/firebase_repository.dart';

class AdminTeamScreen extends ConsumerWidget {
  const AdminTeamScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestoreRepository = ref.watch(firestoreRepositoryProvider);

    return HomeScaffold(
      backNav: '/home/admin',
      body: Column(
        children: [
          Text('Teams', style: kTextDark36, textAlign: TextAlign.center),
          gapH16,
          FirestoreListView<Team>(
            shrinkWrap: true,
            query: firestoreRepository.teamsQuery(),
            errorBuilder: (context, error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
            emptyBuilder: (context) => const Center(
              child: Text('no data'),
            ),
            itemBuilder:
                (BuildContext context, QueryDocumentSnapshot<Team> doc) {
              final team = doc.data();
              return ListTile(
                title: Text(
                  team.name,
                  style: kTextDark20,
                ),
                subtitle: Text('${team.players.length.toString()} players  |  ${team.sport}'),
                trailing: const TeamInfoPopup(),
              );
            },
          ),
        ],
      ),
    );
  }
}
