import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locker_room/constants/text_styles.dart';
import 'package:locker_room/data/game.dart';
import 'package:locker_room/data/location.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../data/firebase_repository.dart';
import '../../data/providers.dart';
import '../../data/team.dart';

class ScheduleTile extends ConsumerWidget {
  const ScheduleTile({super.key, required this.team});

  final Team team;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestoreRepository = ref.watch(firestoreRepositoryProvider);

    return Column(
      children: [
        for (String game in team.games)
          FirestoreListView(
            query: firestoreRepository.gameQuery(game),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, doc) {
              final game = doc.data();
              var teams = firestoreRepository.twoTeamNames(game.team1, game.team2);
              Location location = findLocation(game.location);

              return FutureBuilder(
                future: teams,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: GameDetailTile(snapshot: snapshot, game: game, location: location),
                    );
                  } else if (snapshot.hasError) {
                    return const Icon(Icons.error_outline);
                  } else {
                    return const LinearProgressIndicator();
                  }
                },
              );
            },
          ),
      ],
    );
  }
}

class GameDetailTile extends ConsumerWidget {
  const GameDetailTile({
    super.key,
    required this.game,
    required this.location,
    required this.snapshot,
  });

  final Game game;
  final Location location;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formatter = ref.watch(dateFormatterProvider);

    return ListTile(
      title: Text(
        '${snapshot.data[0]} vs ${snapshot.data[1]}',
        style: kTextDark20,
        textAlign: TextAlign.start,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(formatter.format(game.time)),
          GestureDetector(
            onTap: () =>
                MapsLauncher.launchQuery(location.address),
            child: Text('@ ${location.name}', style: const TextStyle(color: Colors.blue),),
          )
        ],
      ),
    );
  }
}
