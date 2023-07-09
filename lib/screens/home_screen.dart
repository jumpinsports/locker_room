import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/firebase_repository.dart';
import '../data/team.dart';
import '../routing/app_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Locker Room'), actions: [
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () => context.goNamed(AppRoute.profile.name),
        )
      ]),
      body: const TeamListView(),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     debugPrint('Not implemented');
      //   },
      // ),
    );
  }
}


class TeamListView extends ConsumerWidget {
  const TeamListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestoreRepository = ref.watch(firestoreRepositoryProvider);
    final user = ref.watch(firebaseAuthProvider).currentUser;

    return FirestoreListView<Team>(
      query: firestoreRepository.teamsQuery(user!.uid),
      errorBuilder: (context, error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
      emptyBuilder: (context) => const Center(
        child: Text('no data'),
      ),
      itemBuilder: (BuildContext context, QueryDocumentSnapshot<Team> doc) {
        final team = doc.data();
        return ListTile(
          title: team.name == null ? Text('no name') : Text(team.name!),
          subtitle: Text('${team.sport} | ${team.season}'),
          // onTap: () {
          //   /// Add document to Firestore using addJob method in Firebase Repository
          //   final user = ref.read(firebaseAuthProvider).currentUser;
          //   final faker = Faker();
          //   final title = faker.job.title();
          //   final company = faker.company.name();
          //   ref.read(firestoreRepositoryProvider).updateJob(
          //     user!.uid,
          //     doc.id,
          //     title,
          //     company,
          //   );
          // },
        );
      },
    );
  }
}
