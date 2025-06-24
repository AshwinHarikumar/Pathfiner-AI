import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RoadmapLoadingWidget extends StatelessWidget {
  const RoadmapLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[850]!,
      highlightColor: Colors.grey[800]!,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          child: ListTile(
            leading: CircleAvatar(backgroundColor: Colors.grey[850]),
            title: Container(
              height: 20,
              width: 200,
              color: Colors.grey[850],
            ),
          ),
        ),
      ),
    );
  }
}