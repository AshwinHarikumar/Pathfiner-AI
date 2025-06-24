import 'dart:convert';
import 'package:http/http.dart' as http;
import '/main.dart';
import '/models/roadmap_model.dart';

class ApiService {
  static const String _baseUrl = 'https://pathfinder-backend-7qft.onrender.com';

  Future<Roadmap> generateRoadmap({
    required String goal,
    required String experience,
    List<String>? currentSkills,
  }) async {
    final uri = Uri.parse('$_baseUrl/generate-roadmap');
    
    // Get the current user session from Supabase
    final session = supabase.auth.currentSession;
    if (session == null) {
      throw Exception('Not authenticated. Please sign in again.');
    }
    
    // Prepare the authorization header with the user's JWT
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${session.accessToken}',
    };
    
    // The user_id is no longer needed in the body
    final body = json.encode({
      'goal': goal,
      'experience': experience,
      'current_skills': currentSkills ?? [],
    });

    try {
      final response = await http.post(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        return roadmapFromJson(response.body);
      } else {
        final error = json.decode(response.body);
        throw Exception('Failed to generate roadmap: ${error['message']}');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to connect to the server. Please check your network connection.');
    }
  }
}