// lib/services/auth_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

class AuthService {
  final SupabaseClient _client = SupabaseConfig.client;

  // Sign Up (updated as per your instruction)
  Future<void> signup(String email, String password) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Signup failed. Try again.');
    }
    // You can also do: response.session?.user ?? throw ...
  }

  // Login (keeping it returning AuthResponse - consistent style)
  Future<AuthResponse> login(String email, String password) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Logout
  Future<void> logout() async {
    await _client.auth.signOut();
  }

  // Optional: current user getter
  User? get currentUser => _client.auth.currentUser;
}