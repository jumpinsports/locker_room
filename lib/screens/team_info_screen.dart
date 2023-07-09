import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locker_room/constants/colors.dart';
import 'package:locker_room/constants/text_styles.dart';
import 'package:locker_room/widgets/outline_button.dart';
import 'package:locker_room/widgets/team_info/schedule_tile.dart';
import 'package:locker_room/widgets/title_app_bar.dart';

import '../constants/app_sizes.dart';
import '../data/firebase_repository.dart';
import '../data/player.dart';
import '../data/team.dart';
import '../widgets/team_info/change_name_dialog.dart';
import '../widgets/team_info/location_tile.dart';
import '../widgets/team_info/team_member_tile.dart';

class TeamInfoScreen extends ConsumerWidget {
  const TeamInfoScreen({Key? key, required this.teamId}) : super(key: key);

  final String teamId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestoreRepository = ref.watch(firestoreRepositoryProvider);

    return SafeArea(
      child: Scaffold(
        appBar: const TitleAppBar(backNav: '/home'),
        body: FirestoreListView<Team>(
          shrinkWrap: true,
          query: firestoreRepository.teamsQuery(teamId),
          errorBuilder: (context, error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          emptyBuilder: (context) => const Center(
            child: Text('no data'),
          ),
          itemBuilder: (BuildContext context, QueryDocumentSnapshot<Team> doc) {
            final team = doc.data();
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 16,
              ),
              child: Column(
                children: [
                  AutoSizeText(
                    team.name,
                    style: kTextDark36,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  gapW12,
                  ChangeTeamNameButton(teamId: teamId),
                  gapH12,
                  Text('${team.season} ${team.sport}', style: kTextDark20),
                  gapH24,
                  ExpansionTile(
                    title: Text('Team', style: kRTextDark28),
                    children: [TeamMemberTile(team: team)],
                  ),
                  ExpansionTile(
                    title: Text('Game Schedule', style: kRTextDark28),
                    children: [ScheduleTile(team: team)],
                  ),
                  // ExpansionTile(
                  //   title: Text('Location', style: kRTextDark28),
                  //   children: const [LocationTile()],
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChangeTeamNameButton extends StatelessWidget {
  const ChangeTeamNameButton({
    super.key,
    required this.teamId,
  });

  final String teamId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => ChangeNameDialog(teamId: teamId),
        );
      },
      child: const Text(
        'Change team name',
        style: TextStyle(color: Colors.blueAccent, fontSize: 18),
      ),
    );
  }
}
