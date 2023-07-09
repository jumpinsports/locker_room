import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/text_styles.dart';
import '../../data/firebase_repository.dart';
import '../../data/player.dart';
import '../../data/team.dart';

class TeamMemberTile extends ConsumerWidget {
  const TeamMemberTile({super.key, required this.team});

  final Team team;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestoreRepository = ref.watch(firestoreRepositoryProvider);

    return FutureBuilder(
      future: firestoreRepository.playersOnTeam(team),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              List<Player> players = snapshot.data;
              return ListTile(
                title: Text(
                  '${players[index].first} ${players[index].last}',
                  style: kTextDark20,
                ),
                subtitle: Text(players[index].email),
              );
            },
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          );
        } else if (snapshot.hasError) {
          return const Icon(Icons.error_outline);
        } else {
          return const LinearProgressIndicator();
        }
      },
    );
  }
}
