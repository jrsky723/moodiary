import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/users/models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createProfile(UserProfileModel profile) async {
    await _db.collection('users').doc(profile.uid).set(profile.toJson());
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.data();
  }

  Future<void> deleteProfile(String uid) async {
    await _db.collection('users').doc(uid).delete();
    await _storage.ref().child('avatars/$uid').delete();
  }

  Future<void> uploadAvatar({
    required File file,
    required String filename,
  }) async {
    String avatarUrl = 'avatars/$filename';
    final ref = _storage.ref().child(avatarUrl);
    await ref.putFile(file);
  }

  Future<void> updateUser({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    await _db.collection('users').doc(uid).update(data);
  }

  Future<void> updateCommunityOwnerByDiaryIds({
    required Map<String, dynamic> profile,
    required QuerySnapshot<Map<String, dynamic>> diaries,
  }) async {
    final batch = _db.batch();
    for (final doc in diaries.docs) {
      final diaryDocRef = _db.collection('community').doc(doc.id);

      batch.update(diaryDocRef, {'owner': profile});
    }
  }
}

final userRepo = Provider(
  (ref) => UserRepository(),
);
