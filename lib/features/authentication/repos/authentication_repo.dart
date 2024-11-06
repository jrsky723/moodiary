import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final baseUrl = '${dotenv.env['API_BASE_URL']}/auth';

  bool get isLoggedIn => user != null;
  User? get user => _firebaseAuth.currentUser;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<bool> checkUsername(String username) async {
    String url = '$baseUrl/check-username?username=$username';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      log('Failed to check username');
      throw Exception('Failed to check username');
    }
    final data = jsonDecode(response.body);
    return data['isExists'];
  }

  Future<UserCredential> emailSignUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> deleteAccount() async {
    await _firebaseAuth.currentUser?.delete();
  }

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> googleSignIn() async {
    await _firebaseAuth.signInWithProvider(GoogleAuthProvider());
  }
}

final authRepo = Provider((ref) => AuthenticationRepository());

final authState = StreamProvider((ref) {
  final repo = ref.watch(authRepo);
  return repo.authStateChanges();
});
