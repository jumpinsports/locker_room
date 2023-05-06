import 'package:equatable/equatable.dart';

/// Model class for documents in the seasons collection
class Season extends Equatable {
  const Season({
    // required this.uid,
    required this.name,
    required this.sport,
    required this.current
    // required this.games,
  });
  // final String uid;
  final String name;
  final String sport;
  final bool current;
  // final List<Game> games;

  factory Season.fromMap(Map<String, dynamic> map) {
    return Season(
      // uid: map['uid'] as String,
      name: map['name'] as String,
      sport: map['sport'] as String,
      current: map['current'] as bool,
      // games: map['games'] as List<Game>,
    );
  }

  Map<String, dynamic> toMap() => {
        // 'uid': uid,
        'name': name,
        'sport': sport,
        'current': current,
        // 'games': games,
      };

  @override
  List<Object?> get props => [
        // uid,
        name,
        sport,
        current,
        // games,
      ];
}
