import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/users/models/user_profile_model.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final apiBaseUrl = '${dotenv.env['API_BASE_URL']!}/client';

  Future<void> createProfile(UserProfileModel profile) async {
    String url = '$apiBaseUrl/create-user';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(profile.toJson()),
      );
      log(response.body);
      if (response.statusCode != 200) {
        throw Exception('Failed to create user');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    String url = '$apiBaseUrl/find-profile';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'uid': uid,
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to find user');
      }
      return jsonDecode(response.body);
    } catch (e) {
      log(e.toString());
      return null;
    }
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
    String url = '$apiBaseUrl/update-user';
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'uid': uid,
        },
        body: jsonEncode(data),
      );
      log(response.body);
      if (response.statusCode != 200) {
        throw Exception('Failed to update user');
      }
    } catch (e) {
      log(e.toString());
    }
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
