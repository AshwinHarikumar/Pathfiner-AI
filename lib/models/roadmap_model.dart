import 'dart:convert';

// Helper function to decode the JSON response string
Roadmap roadmapFromJson(String str) => Roadmap.fromJson(json.decode(str));

class Roadmap {
  final String roadmapTitle;
  final List<RoadmapStep> steps;

  Roadmap({
    required this.roadmapTitle,
    required this.steps,
  });

  factory Roadmap.fromJson(Map<String, dynamic> json) => Roadmap(
        roadmapTitle: json["roadmap_title"],
        steps: List<RoadmapStep>.from(json["steps"].map((x) => RoadmapStep.fromJson(x))),
      );
}

class RoadmapStep {
  final int stepNumber;
  final String title;
  final String description;
  final List<String> keyTopics;
  final String projectIdea;
  final List<Course> courses;

  RoadmapStep({
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.keyTopics,
    required this.projectIdea,
    required this.courses,
  });

  factory RoadmapStep.fromJson(Map<String, dynamic> json) => RoadmapStep(
        stepNumber: json["step_number"],
        title: json["title"],
        description: json["description"],
        keyTopics: List<String>.from(json["key_topics"].map((x) => x)),
        projectIdea: json["project_idea"],
        courses: List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
      );
}

class Course {
  final String platform;
  final String title;
  final String headline;
  final String url;
  final String image;
  final String instructor;

  Course({
    required this.platform,
    required this.title,
    required this.headline,
    required this.url,
    required this.image,
    required this.instructor,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        platform: json["platform"],
        title: json["title"],
        headline: json["headline"],
        url: json["url"],
        image: json["image"],
        instructor: json["instructor"],
      );
}
