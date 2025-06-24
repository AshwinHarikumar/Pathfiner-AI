import 'package:flutter/material.dart';
import '/main.dart'; // Assuming this imports 'supabase'
import '/screens/home_screen.dart';
import '/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// --- UI Constants for a Consistent App-Wide Theme ---
class _UIConstants {
  // Using the same professional green color palette as HomeScreen
  static const Color primaryGreen = Color(0xFF00695C);
  static const Color secondaryGreen = Color(0xFF004D40);
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    // StreamBuilder listens to authentication state changes from Supabase
    return StreamBuilder<AuthState>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        // If the snapshot has no data yet, it means we are waiting for the initial auth state.
        // Show a styled loading screen during this time.
        if (!snapshot.hasData) {
          return const _StyledLoadingScreen();
        }

        // If we have data, we check for an active session.
        final session = snapshot.data?.session;
        if (session != null) {
          // User is logged in, show the home screen
          return const HomeScreen();
        } else {
          // User is not logged in, show the login screen
          return const LoginScreen();
        }
      },
    );
  }
}

/// A private helper widget for the styled loading screen to keep the build method clean.
class _StyledLoadingScreen extends StatelessWidget {
  const _StyledLoadingScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _UIConstants.primaryGreen,
              _UIConstants.secondaryGreen,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: StreamBuilder<AuthState>(
            stream: supabase.auth.onAuthStateChange,
            builder: (context, snapshot) {
              // If the snapshot has no data yet, it means we are waiting for the initial auth state.
              // Show a styled loading screen during this time.
              if (!snapshot.hasData) {
                return const _StyledLoadingScreen();
              }

              // If we have data, we check for an active session.
              final session = snapshot.data?.session;
              if (session != null) {
                // User is logged in, show the home screen
                return const HomeScreen();
              } else {
                // User is not logged in, show the login screen
                return const LoginScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}