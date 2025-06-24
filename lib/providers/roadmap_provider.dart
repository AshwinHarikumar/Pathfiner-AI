import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/models/roadmap_model.dart';
import '/services/api_service.dart';

// Provider for our ApiService instance
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

// This is where the magic happens. A FutureProvider is perfect for handling
// asynchronous operations like API calls. It automatically manages loading,
// data, and error states for us.
final roadmapProvider = FutureProvider.family<Roadmap, Map<String, dynamic>>(
  (ref, query) async {
    // Watch the apiServiceProvider to get the ApiService instance.
    final apiService = ref.watch(apiServiceProvider);
    
    // Call our API service with the user's input.
    return apiService.generateRoadmap(
      goal: query['goal'],
      experience: query['experience'],
      currentSkills: query['skills'],
    );
  },
);