import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/authentication/views/avatar_screen.dart';
import 'package:moodiary/utils/firebase_utils.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<bool> checkUsername(BuildContext context, String username) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () async {
        final exists = await _authRepo.checkUsername(username);

        if (exists) {
          throw Exception('Username already exists');
        }
      },
    );
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
      return false;
    }
    return true;
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();

    final form = ref.read(signUpForm);
    state = await AsyncValue.guard(
      () async {
        final user = await _authRepo.emailSignUp(
          form["email"],
          form["password"],
        );
        form["uid"] = user.user!.uid;
      },
    );
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    }

    context.goNamed(
      AvatarScreen.routeName,
      extra: form["username"],
    );
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
