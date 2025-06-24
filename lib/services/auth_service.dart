import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/main.dart'; // To get the global supabase client
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final GoTrueClient _auth = supabase.auth;

  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithPassword(email: email, password: password);
    } on AuthException catch (e) {
      throw Exception('Failed to sign in: ${e.message}');
    } catch (e) {
      throw Exception('An unknown error occurred.');
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    try {
      await _auth.signUp(email: email, password: password);
    } on AuthException catch (e) {
      throw Exception('Failed to sign up: ${e.message}');
    } catch (e) {
      throw Exception('An unknown error occurred.');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

// Riverpod provider for the AuthService
final authServiceProvider = Provider<AuthService>((ref) => AuthService());
