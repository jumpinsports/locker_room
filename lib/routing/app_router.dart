import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:locker_room/admin/admin_home_screen.dart';
import 'package:locker_room/screens/team_select_screen.dart';
import 'package:locker_room/screens/team_info_screen.dart';

import '../admin/admin_game_screen.dart';
import '../admin/admin_player_screen.dart';
import '../admin/admin_team_screen.dart';
import '../screens/custom_login_screen.dart';
import '../screens/custom_profile_screen.dart';
import 'go_router_refresh_stream.dart';

enum AppRoute {
  signIn,
  home,
  profile,
  joinTeam,
  teamInfo,
  admin,
  adminPlayer,
  adminTeam,
  adminGame,
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
          GoRoute(
            path: 'admin',
            name: AppRoute.admin.name,
            builder: (context, state) => const AdminHomeScreen(),
            routes: [
              GoRoute(
                path: 'player',
                name: AppRoute.adminPlayer.name,
                builder: (context, state) => const AdminPlayerScreen(),
              ),
              GoRoute(
                path: 'team',
                name: AppRoute.adminTeam.name,
                builder: (context, state) => const AdminTeamScreen(),
              ),
              GoRoute(
                path: 'game',
                name: AppRoute.adminGame.name,
                builder: (context, state) => const AdminGameScreen(),
              ),
            ]
          ),
        ],
      ),

      /// TODO: Debug - this causes new routes to assume the route is a teamId
      GoRoute(
        path: '/:teamId',
        name: AppRoute.teamInfo.name,
        builder: (BuildContext context, GoRouterState state) {
          print(state.pathParameters['teamId']!);
          final teamId = state.pathParameters['teamId']!;
          return TeamInfoScreen(
            teamId: teamId,
          );
        },
      ),
    ],
  );
});