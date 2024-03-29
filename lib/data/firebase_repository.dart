import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locker_room/data/player.dart';
import 'package:locker_room/data/team.dart';

import 'game.dart';

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

  /// Updates 'name' field of a team
  Future<void> changeTeamName(String teamId, String newName) async {
    final docRef = _firestore.collection('football_summer2023').doc(teamId);
    await docRef.update({'name': newName});
  }

  /// Returns a team from the teams collection
  Query<Team> teamQuery(String teamId) {
    return _firestore
        .collection('football_summer2023')
        .where(FieldPath.documentId, isEqualTo: teamId)
        .withConverter(
          fromFirestore: (snapshot, _) => Team.fromMap(snapshot.data()!),
          toFirestore: (team, _) => team.toMap(),
        );
  }

  /// Return the name a team from teamId
  Future<String> teamName(String teamId) async {
    final ref = _firestore
        .collection('football_summer2023')
        .where(FieldPath.documentId, isEqualTo: teamId)
        .withConverter(
          fromFirestore: (snapshot, _) => Team.fromMap(snapshot.data()!),
          toFirestore: (team, _) => team.toMap(),
        );
    final docSnap = await ref.get();
    final team = docSnap.docs[0].data();
    return team.name;
  }

  /// Return a list of all teams as Team objects
  Query<Team> teamsQuery() {
    return _firestore.collection('football_summer2023').withConverter(
          fromFirestore: (snapshot, _) => Team.fromMap(snapshot.data()!),
          toFirestore: (team, _) => team.toMap(),
        );
  }

  /// Return the names of the teams from two teamIds
  /// Used to populate Game Schedule section
  Future<List<String>> twoTeamNames(String team1Id, String team2Id) async {
    List<String> teamIds = [team1Id, team2Id];
    List<String> teamNames = [];
    for (String id in teamIds) {
      final ref = _firestore
          .collection('football_summer2023')
          .where(FieldPath.documentId, isEqualTo: id)
          .withConverter(
            fromFirestore: (snapshot, _) => Team.fromMap(snapshot.data()!),
            toFirestore: (team, _) => team.toMap(),
          );
      final docSnap = await ref.get();
      final team = docSnap.docs[0].data();
      teamNames.add(team.name);
    }
    return teamNames;
  }

  /// Finds a player from the Players collection from their email address
  /// Used to connect newly logged in players to their data
  Query<Player> playerQuery(String email) {
    return _firestore
        .collection('players')
        .where('email', isEqualTo: email)
        .withConverter(
          fromFirestore: (snapshot, _) => Player.fromMap(snapshot.data()!),
          toFirestore: (player, _) => player.toMap(),
        );
  }

  /// Finds all players from the Players collection
  /// Sorted by last name
  Query<Player> playersQuery() {
    return _firestore.collection('players').orderBy('last').withConverter(
          fromFirestore: (snapshot, _) => Player.fromMap(snapshot.data()!),
          toFirestore: (player, _) => player.toMap(),
        );
  }

  Future<List<Player>> playersOnTeam(Team team) async {
    List<Player> playerList = [];
    for (String player in team.players) {
      final ref = _firestore
          .collection('players')
          .where(FieldPath.documentId, isEqualTo: player)
          .withConverter(
            fromFirestore: (snapshot, _) => Player.fromMap(snapshot.data()!),
            toFirestore: (team, _) => team.toMap(),
          );
      final docSnap = await ref.get();
      final thisPlayer = docSnap.docs[0].data();
      playerList.add(thisPlayer);
    }
    return playerList;
  }

  /// Updates 'first' field of a player
  Future<void> changePlayerFirst(String playerId, String newName) async {
    final docRef = _firestore.collection('players').doc(playerId);
    await docRef.update({'first': newName});
  }

  /// Updates 'last' field of a player
  Future<void> changePlayerLast(String playerId, String newName) async {
    final docRef = _firestore.collection('players').doc(playerId);
    await docRef.update({'last': newName});
  }

  /// Updates 'email' field of a player
  Future<void> changePlayerEmail(String playerId, String newEmail) async {
    final docRef = _firestore.collection('players').doc(playerId);
    await docRef.update({'email': newEmail});
  }

  /// Updates 'team' field of a player
  Future<void> changePlayerTeam(
      String playerId, String currentTeamId, String newTeamId) async {
    final docRef = _firestore.collection('players').doc(playerId);
    await docRef.update({
      'teams': FieldValue.arrayRemove([currentTeamId])
    });
    await docRef.update({
      'teams': FieldValue.arrayUnion([newTeamId])
    });
  }

  /// Finds a player from the Players collection from their playerId
  /// Used to find a player from the team player list
  Query<Player> teamPlayerQuery(String playerId) {
    return _firestore
        .collection('players')
        .where(FieldPath.documentId, isEqualTo: playerId)
        .withConverter(
          fromFirestore: (snapshot, _) => Player.fromMap(snapshot.data()!),
          toFirestore: (team, _) => team.toMap(),
        );
  }

  /// Returns a game from the Seasons>Games collection from gameId
  Query<Game> gameQuery(String gameId) {
    return _firestore
        .collection('seasons')
        .doc('spring2023football')
        .collection('games')
        .where(FieldPath.documentId, isEqualTo: gameId)
        .withConverter(
          fromFirestore: (snapshot, _) => Game.fromMap(snapshot.data()!),
          toFirestore: (game, _) => game.toMap(),
        );
  }
}

/// Provider provides Firestore instance
final firestoreRepositoryProvider = Provider<FirestoreRepository>((ref) {
  return FirestoreRepository(FirebaseFirestore.instance);
});
