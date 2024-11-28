import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodiary/common/main_navigation_screen.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/authentication/view_models/signup_view_model.dart';
import 'package:moodiary/features/authentication/views/username_screen.dart';
import 'package:moodiary/utils/firebase_utils.dart';

class SocialAuthViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> googleSignIn(BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final credential = await _repository.signInWithGoogle();
        if (credential != null) {
          if (credential.additionalUserInfo!.isNewUser) {
            ref.read(signUpForm.notifier).state = {
              "uid": credential.user!.uid,
              "email": credential.user!.email,
            };
            context.goNamed(UsernameScreen.routeName);
          } else {
            context.go('/${MainNavigationScreen.initialTab}');
          }
        }
      },
    );
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
      return;
    }
  }
}

final socialAuthProvider = AsyncNotifierProvider<SocialAuthViewModel, void>(
  () => SocialAuthViewModel(),
);
