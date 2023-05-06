import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locker_room/data/team.dart';

/// Controls CRUD operations between app and Firestore
class FirestoreRepository {
  FirestoreRepository(this._firestore);
  final FirebaseFirestore _firestore;

  // /// Write a new document to Firestore
  // Future<void> addJob(String uid, String title, String company) async {
  //   final docRef = await _firestore.collection('jobs').add({
  //     'uid': uid,
  //     'title': title,
  //     'company': company,
  //   });
  //   print(docRef.id);
  // }

  /// Returns a Firestore query from the teams collection
  Query<Team> teamsQuery() {
    return _firestore.collection('teams').withConverter(
      fromFirestore: (snapshot, _) => Team.fromMap(snapshot.data()!),
      toFirestore: (team, _) => team.toMap(),
    );
  }
}

/// Provider provides Firestore instance
final firestoreRepositoryProvider = Provider<FirestoreRepository>((ref) {
  return FirestoreRepository(FirebaseFirestore.instance);
});
