import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/users/models/user_profile_model.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final _apiBaseUrl = '${dotenv.env['API_BASE_URL']!}/client';

  Future<void> createProfile(UserProfileModel profile) async {
    String url = '$_apiBaseUrl/create-profile';
    try {
      log("createProfile: ${profile.toJson()}");
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(profile.toJson()),
      );
      log("createProfile: ${response.body}");
      if (response.statusCode != 200) {
        throw Exception('Failed to create user');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    String url = '$_apiBaseUrl/find-profile';
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

  Future<void> uploadAvatar({
    required File file,
    required String filename,
  }) async {
    String avatarUrl = 'avatars/$filename';
    final ref = _storage.ref().child(avatarUrl);
    await ref.putFile(file);
  }

  Future<void> updateProfile({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    String url = '$_apiBaseUrl/update-profile';
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

  Future<void> deleteProfile(String uid) async {
    String url = '$_apiBaseUrl/delete-profile';
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'uid': uid,
        },
      );
      log(response.body);
      if (response.statusCode != 200) {
        throw Exception('Failed to delete user');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

final userRepo = Provider(
  (ref) => UserRepository(),
);
