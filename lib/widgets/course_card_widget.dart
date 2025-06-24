import 'package:flutter/material.dart';
import '/models/roadmap_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseCardWidget extends StatelessWidget {
  final Course course;

  const CourseCardWidget({super.key, required this.course});

  Future<void> _launchUrl() async {
    final uri = Uri.parse(course.url);
    if (!await launchUrl(uri)) {
      // You can show a Snackbar or Toast here if the URL fails to launch
      print('Could not launch ${course.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: _launchUrl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                course.image,
                height: 80,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(height: 80, color: Colors.grey[800], child: const Icon(Icons.school)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.platform,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}