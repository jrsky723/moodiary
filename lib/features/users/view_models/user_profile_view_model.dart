import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/diary/repos/diary_repo.dart';
import 'package:moodiary/features/users/models/user_profile_model.dart';
import 'package:moodiary/features/users/repos/user_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileViewModel extends AutoDisposeAsyncNotifier<UserProfileModel> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  late final DiaryRepository _diaryRepo;
  late final UserRepository _userRepo;
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<UserProfileModel> build() async {
    _diaryRepo = ref.read(diaryRepo);
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

  Future<void> createProfile(UserCredential credential) async {
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      uid: credential.user!.uid,
      bio: 'undefined',
      nickname: 'undefined',
      username: credential.user!.displayName ?? 'username',
      hasAvatar: false,
    );
    await _userRepo.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> onAvatarUploaded() async {
    state = const AsyncValue.loading();
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(
      hasAvatar: true,
    ));
  }

  Future<void> updateUserProfile(Map<String, dynamic> profile) async {
    // Map<String, dynamic> 형태로 변환
    final user = ref.read(authRepo).user;
    final uid = user!.uid;
    state = const AsyncValue.loading();
    await _userRepo.updateUser(
      uid: uid,
      user: profile,
    );
    state = AsyncValue.data(state.value!.copyWith(
      username: profile['username'],
      nickname: profile['nickname'],
      bio: profile['bio'],
      hasAvatar: profile['hasAvatar'],
    ));
  }

  Future<void> updateCommunityOwnerByDiaryId(
      Map<String, dynamic> profile) async {
    final user = ref.read(authRepo).user;
    final uid = user!.uid;

    final diaries = await _diaryRepo.fetchDiariesByUId(uid);

    final batch = _db.batch();
    for (final doc in diaries.docs) {
      final diaryDocRef = _db.collection('community').doc(doc.id);

      batch.update(diaryDocRef, {'owner': profile});
    }
  }
}

final userProfileProvider =
    AutoDisposeAsyncNotifierProvider<UserProfileViewModel, UserProfileModel>(
  () => UserProfileViewModel(),
);
