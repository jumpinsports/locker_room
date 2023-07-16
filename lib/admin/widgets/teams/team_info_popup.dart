import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeamInfoPopup extends ConsumerWidget {
  const TeamInfoPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Icon(Icons.edit, size: 24);
  }
}
