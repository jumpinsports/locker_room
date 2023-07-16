import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_sizes.dart';
import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';
import '../../../data/firebase_repository.dart';
import '../../../data/player.dart';
import '../../../data/providers.dart';
import '../../../widgets/outline_button.dart';

class EditPlayerRow extends ConsumerWidget {
  const EditPlayerRow({
    super.key,
    required this.player,
    required this.item,
  });

  final Player player;
  final String item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestoreRepository = ref.watch(firestoreRepositoryProvider);
    final playerId = ref.watch(playerIdProvider);
    TextEditingController editController = TextEditingController();

    String itemToEdit() {
      if (item == 'first') {
        return player.first;
      }
      if (item == 'last') {
        return player.last;
      }
      if (item == 'email') {
        return player.email;
      }
      if (item == 'team') {
        return player.teams.toString();
      }
      return 'no data';
    }

    Future<void> editFunction() {
      if (item == 'first') {
        return firestoreRepository.changePlayerFirst(
            playerId, editController.text);
      }
      if (item == 'last') {
        return firestoreRepository.changePlayerLast(
            playerId, editController.text);
      }
      if (item == 'email') {
        return firestoreRepository.changePlayerEmail(
            playerId, editController.text);
      }
      // if (item == 'team') {
      //   return player.teams.toString();
      // }
      return firestoreRepository.changePlayerFirst(
          playerId, editController.text);
    }

    return Row(
      children: [
        AutoSizeText(itemToEdit(), style: kTextDark20),
        const Spacer(),
        GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: editController,
                    autocorrect: false,
                  ),
                  gapH20,
                  Row(
                    children: [
                      OutlineButton(
                        function: () {
                          editFunction();
                          Navigator.of(context).pop();
                        },
                        title: 'OK',
                      ),
                      const Spacer(),
                      OutlineButton(
                        function: () => Navigator.of(context).pop(),
                        title: 'Cancel',
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
