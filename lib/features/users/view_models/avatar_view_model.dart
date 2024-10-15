import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/users/repos/user_repo.dart';
import 'package:moodiary/features/users/view_models/user_profile_view_model.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final UserRepository _repo;

  @override
  FutureOr<void> build() {
    _repo = ref.read(userRepo);
  }

  Future<void> uploadAvatar(File file) async {
    state = const AsyncValue.loading();
    final uid = ref.read(authRepo).user!.uid;
    state = await AsyncValue.guard(
      () async {
        await _repo.uploadAvatar(file: file, filename: uid);
        ref.read(userProfileProvider.notifier).onAvatarUploaded();
      },
    );
  }
}

final avatarProvider = AsyncNotifierProvider<AvatarViewModel, void>(
  () => AvatarViewModel(),
);
