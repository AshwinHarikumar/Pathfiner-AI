import 'package:flutter/material.dart';
import '/models/roadmap_model.dart';
import '/widgets/course_card_widget.dart';

class RoadmapStepWidget extends StatelessWidget {
  final RoadmapStep step;

  const RoadmapStepWidget({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ExpansionTile(
        leading: CircleAvatar(
          child: Text(step.stepNumber.toString()),
        ),
        title: Text(step.title, style: Theme.of(context).textTheme.titleLarge),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(step.description),
                const SizedBox(height: 12),
                const Text('Key Topics:', style: TextStyle(fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 8.0,
                  children: step.keyTopics.map((topic) => Chip(label: Text(topic))).toList(),
                ),
                const SizedBox(height: 12),
                const Text('Project Idea:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(step.projectIdea),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                const Text('Recommended Courses:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 180, // Constrain the height of the course list
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: step.courses.length,
                    itemBuilder: (context, index) {
                      return CourseCardWidget(course: step.courses[index]);
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
