import 'package:equatable/equatable.dart';

/// Model class for documents in the teams collection
class Team extends Equatable {
  const Team({
    required this.name,
    required this.sport,
    required this.season,
    required this.players,
    required this.games,
  });
  final String name;
  final String sport;
  final String season;
  final List players;
  final List games;

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      name: map['name'] as String,
      sport: map['sport'] as String,
      season: map['season'] as String,
      players: map['players'] as List,
      games: map['games'] as List,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'sport': sport,
        'season': season,
        'players': players,
        'games': games,
      };

  @override
  List<Object?> get props => [name, sport, season, players, games];
}
