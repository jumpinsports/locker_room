import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final dateFormatterProvider = Provider<DateFormat>((ref) {
  return DateFormat('E MMMM d, y');
});


/// Provider required to change a player's team
final playerIdProvider = StateProvider<String>((ref) {
  return currentPlayerId;
});
String currentPlayerId = '';
