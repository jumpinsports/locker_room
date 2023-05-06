import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides all of the auth types in one place
final authProvidersProvider = Provider<List<AuthProvider>>((ref) {
  return [EmailAuthProvider()];
});