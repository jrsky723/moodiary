import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/users/repos/user_repo.dart';
import 'package:moodiary/features/users/view_models/user_profile_view_model.dart';

class AvatarViewModel extends AutoDisposeAsyncNotifier<void> {
  late final UserRepoSitory _repo;

  @override
  FutureOr<void> build() {
    _repo = ref.read(userRepo);
  }

  Future<void> uploadAvatar(File file) async {
    if (state.isLoading) return;
    final uid = ref.read(authRepo).user!.uid;
    state = await AsyncValue.guard(
      () async {
        await _repo.uploadAvatar(file: file, filename: uid);
        await ref.read(usersProvider.notifier).onAvatarUploaded();
      },
    );
  }
}

final avatarProvider = AutoDisposeAsyncNotifierProvider<AvatarViewModel, void>(
  () => AvatarViewModel(),
);
