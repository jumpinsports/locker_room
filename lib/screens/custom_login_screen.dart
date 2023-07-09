import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ui_auth_providers.dart';
import '../widgets/title_app_bar.dart';

class CustomLoginScreen extends ConsumerWidget {
  const CustomLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProviders = ref.watch(authProvidersProvider);

    return SafeArea(
      child: Scaffold(
        appBar: const TitleAppBar(backNav: ''),
        body: SignInScreen(
          providers: authProviders,
        ),
      ),
    );
  }
}
