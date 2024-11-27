import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/authentication/view_models/signup_view_model.dart';
import 'package:moodiary/features/users/models/user_profile_model.dart';
import 'package:moodiary/features/users/repos/user_repo.dart';

class UserProfileViewModel extends AutoDisposeAsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepo;
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<UserProfileModel> build() async {
    _userRepo = ref.read(userRepo);
    _authRepo = ref.read(authRepo);
    if (_authRepo.isLoggedIn) {
      final profile = await _userRepo.findProfile(_authRepo.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
    return UserProfileModel.empty();
  }

  Future<UserProfileModel> createProfile() async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm.notifier).state;
    log('form: $form');
    final profile = UserProfileModel(
      uid: form['uid'],
      bio: form['bio'],
      nickname: form['nickname'],
      username: form['username'],
      hasAvatar: form['hasAvatar'],
    );
    // aws 인스턴스의 유저에 업데이트를 해야함
    await _userRepo.createProfile(profile);
    state = AsyncValue.data(profile);
    return profile;
  }

  Future<void> deleteProfile() async {
    state = const AsyncValue.loading();
    final uid = ref.read(authRepo).user!.uid;

    await _authRepo.deleteAccount();
    await _userRepo.deleteProfile(uid);
  }

  Future<void> onAvatarUpload() async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(hasAvatar: true));
    final uid = state.value!.uid;
    await _userRepo.updateProfile(uid: uid, data: {'hasAvatar': true});
  }

  Future<void> updateUserProfile(Map<String, dynamic> profile) async {
    // Map<String, dynamic> 형태로 변환
    final user = ref.read(authRepo).user;
    final uid = user!.uid;
    state = const AsyncValue.loading();
    await _userRepo.updateProfile(
      uid: uid,
      data: profile,
    );

    state = AsyncValue.data(state.value!.copyWith(
      username: profile['username'],
      nickname: profile['nickname'],
      bio: profile['bio'],
      hasAvatar: profile['hasAvatar'],
    ));
  }
}

final userProfileProvider =
    AutoDisposeAsyncNotifierProvider<UserProfileViewModel, UserProfileModel>(
  () => UserProfileViewModel(),
);
