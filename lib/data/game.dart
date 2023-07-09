import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:locker_room/data/team.dart';

/// Model class for documents in the seasons>games collection
class Game extends Equatable {
  const Game({
    // required this.uid,
    // required this.name,
    // required this.sport,
    required this.team1,
    required this.team2,
    required this.time,
    required this.location,
    // TODO: Add final scores
  });
  // final String uid;
  // final String name;
  // final String sport;
  final String team1;
  final String team2;
  final DateTime time;
  final String location;

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      // uid: map['uid'] as String,
      // name: map['name'] as String,
      // sport: map['sport'] as String,
      team1: map['team1'] as String,
      team2: map['team2'] as String,
      time: map['time'].toDate() as DateTime,
      location: map['location'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
    // 'uid': uid,
    // 'name': name,
    // 'sport': sport,
    'team1': team1,
    'team2': team2,
    'time': time,
    'locationName': location,
  };

  @override
  List<Object?> get props => [
    // uid,
    // name,
    // sport,
    team1,
    team2,
    time,
    location,
  ];
}
