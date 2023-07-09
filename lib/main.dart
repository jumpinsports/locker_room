import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:locker_room/constants/colors.dart';
import 'package:locker_room/routing/app_router.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: kMainDarkColor,
          secondary: kMainLightColor,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: kMainAccentColor,
          linearTrackColor: kMainDarkColor,
        ),
        textTheme: GoogleFonts.jostTextTheme(Theme.of(context).textTheme),
      ),
    );
  }
}
