import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/screens/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // Ensure that Flutter bindings are initialized before calling Supabase
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase. Replace with your actual project details.
  await Supabase.initialize(
    // IMPORTANT: Use your project's anom key, NOT the service role key.
    // This key is safe to expose in client-side code.
    url: 'https://efccvqsscxvkfjkdetix.supabase.co', // Get this from your Supabase project settings
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVmY2N2cXNzY3h2a2Zqa2RldGl4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA1OTkxNDYsImV4cCI6MjA2NjE3NTE0Nn0.m-e802QdBtybOYbdVS9ChfRkAD1c0QqDK39KogcquQQ', // Get this from your Supabase project settings
  );

  runApp(const ProviderScope(child: MyApp()));
}

// Helper to access the Supabase client easily
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pathfinder AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0056D2),
          brightness: Brightness.dark,
          background: const Color(0xFF121212),
        ),
        useMaterial3: true,
        textTheme: Typography.whiteMountainView,
      ),
      // The AuthGate is now the first screen the user sees.
      home: const AuthGate(),
    );
  }
}
