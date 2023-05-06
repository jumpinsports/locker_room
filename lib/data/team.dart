import 'package:equatable/equatable.dart';

/// Model class for documents in the teams collection
class Team extends Equatable {
  const Team({
    required this.uid,
    required this.name,
    required this.sport,
    required this.season,
  });
  final String uid;
  final String name;
  final String sport;
  final String season;

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      uid: map['uid'] as String,
      name: map['name'] as String,
      sport: map['sport'] as String,
      season: map['season'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'name': name,
        'sport': sport,
        'season': season,
      };

  @override
  List<Object?> get props => [uid, name, sport, season];
}
