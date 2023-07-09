import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:locker_room/constants/keys.dart';

import '../../constants/app_sizes.dart';
import '../../constants/text_styles.dart';
import '../../data/firebase_repository.dart';
import '../outline_button.dart';

class ChangeNameDialog extends ConsumerWidget {
  const ChangeNameDialog({
    super.key,
    required this.teamId,
  });

  final String teamId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestoreRepository = ref.watch(firestoreRepositoryProvider);
    TextEditingController nameController = TextEditingController();

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Change team name', style: kTextDark20),
          gapH12,
          TextField(
            controller: nameController,
            textCapitalization: TextCapitalization.words,
            autocorrect: false,
            maxLength: 25,
          ),
          gapH20,
          Row(
            children: [
              OutlineButton(
                function: () {
                  print(nameController.text);
                  firestoreRepository.changeTeamName(
                      teamId, nameController.text);
                  Navigator.of(context).pop();
                },
                title: 'OK',
              ),
              gapW12,
              OutlineButton(
                function: () => Navigator.of(context).pop(),
                title: 'Cancel',
              ),
            ],
          ),
          gapH20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Don\'t sweat it! You can change your team name until 2 weeks prior to season start',
              style: kTextGrey16,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
