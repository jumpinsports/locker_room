import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:locker_room/screens/team_select_screen.dart';
import 'package:locker_room/screens/team_info_screen.dart';

import '../screens/custom_login_screen.dart';
import '../screens/custom_profile_screen.dart';
import '../screens/home_screen.dart';
import 'go_router_refresh_stream.dart';

enum AppRoute {
  signIn,
  home,
  profile,
  joinTeam,
  teamInfo,
}

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final goRouterProvider = Provider<GoRouter>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return GoRouter(
    initialLocation: '/sign-in',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = firebaseAuth.currentUser != null;
      if (isLoggedIn) {
        if (state.location == '/sign-in') {
          return '/home';
        }
      } else {
        if (state.location.startsWith('/home')) {
          return '/sign-in';
        }
      }
      return null;
    },
    /// Executes the redirect function above when the auth state changes
    refreshListenable: GoRouterRefreshStream(firebaseAuth.authStateChanges()),
    routes: [
      GoRoute(
        path: '/sign-in',
        name: AppRoute.signIn.name,
        builder: (context, state) => const CustomLoginScreen(),
      ),
      GoRoute(
        path: '/home',
        name: AppRoute.home.name,
        builder: (context, state) => const TeamSelectScreen(),
        routes: [
          GoRoute(
            path: 'profile',
            name: AppRoute.profile.name,
            builder: (context, state) => const CustomProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/:teamId',
        name: AppRoute.teamInfo.name,
        builder: (BuildContext context, GoRouterState state) {
          final teamId = state.pathParameters['teamId']!;
          return TeamInfoScreen(
            teamId: teamId,
          );
        },
      ),
      // GoRoute(
      //   path: '/joinTeam',
      //   name: AppRoute.joinTeam.name,
      //   builder: (context, state) => const JoinTeamScreen(),
      // ),
    ],
  );
});