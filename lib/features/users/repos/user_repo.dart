import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/users/models/user_profile_model.dart';

class UserRepoSitory {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createProfile(UserProfileModel profile) async {
    await _db.collection('users').doc(profile.uid).set(profile.toJson());
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    print("test ${doc.data()}");
    return doc.data();
  }

  Future<void> uploadAvatar({
    required File file,
    required String filename,
  }) async {
    // TODO : 파일이름 뭘로?
    String baseUrl = 'avatars/$filename';
    final ref = _storage.ref().child(baseUrl);
    await ref.putFile(file);
  }

  Future<void> updateUser(
      {required String uid, required Map<String, dynamic> user}) async {
    await _db.collection('users').doc(uid).update(user);
  }
}

final userRepo = Provider(
  (ref) => UserRepoSitory(),
);
