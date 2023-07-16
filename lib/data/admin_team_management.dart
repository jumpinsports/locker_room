import "dart:math";

Map<String, List<String>> createMatches(List<String> teams, int numGames) {
  Map<String, List<String>> matches = {};

  /// Generate an empty list of opponents for each team
  for (String team in teams) {
    teams[Random().nextInt(teams.length - 1)];
  }

  /// Each week
  // for (int i = 1; i < numGames; i++) {

  /// Each team
  for (String team in teams) {}
  // }
  return matches;
}
