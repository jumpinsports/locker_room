import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:locker_room/constants/text_styles.dart';
import 'package:locker_room/widgets/home_scaffold.dart';

import '../constants/app_sizes.dart';
import '../data/firebase_repository.dart';
import '../data/player.dart';
import '../data/team.dart';
import '../routing/app_router.dart';

class TeamSelectScreen extends ConsumerWidget {
  const TeamSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(firebaseAuthProvider).currentUser;
    final firestoreRepository = ref.watch(firestoreRepositoryProvider);

    return HomeScaffold(
      backNav: '/sign-in',
      body: FirestoreListView<Player>(
        query: firestoreRepository.playerQuery(user!.email!),
        shrinkWrap: true,
        errorBuilder: (context, error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        emptyBuilder: (context) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Registration not found (yet).\n\nNote: It can take up to 48 hours after registration before the Locker Room app is available.',
              style: kTextDark20,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        itemBuilder: (BuildContext context, QueryDocumentSnapshot<Player> doc) {
          final player = doc.data();
          return Column(
            children: [
              gapH20,
              Text('Welcome ${player.first}', style: kTextDark28),
              Text(player.email),
              player.teams[0] == ''
                  ? const NoTeamAssigned()
                  : FirestoreListView<Team>(
                      shrinkWrap: true,
                      query: firestoreRepository.teamQuery(player.teams[0]),
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Text(error.toString()),
                      ),
                      emptyBuilder: (context) => const Center(
                        child: Text('no data'),
                      ),
                      itemBuilder: (BuildContext context,
                          QueryDocumentSnapshot<Team> doc) {
                        final team = doc.data();
                        return ListTile(
                          onTap: () => context.go('/${doc.id}'),
                          title: Text(team.name),
                          subtitle: Text(team.season),
                        );
                      },
                    ),
            ],
          );
        },
      ),
    );
  }
}

class NoTeamAssigned extends StatelessWidget {
  const NoTeamAssigned({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String noTeamText =
        'You have not been assigned to a team yet.\n\nYou will receive an email once your team has been assigned and your team information will be shown here.\n\nTeam assignments will be made at least one week prior to season start.';

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Text(
        noTeamText,
        style: kTextDark16,
        textAlign: TextAlign.center,
      ),
    );
  }
}
