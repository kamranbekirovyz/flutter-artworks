import 'package:app/app/data/models/story.dart';
import 'package:app/app/views/stories_view.dart';
import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  final Story story;
  final int index;

  const StoryItem(
    this.story, {
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => StoriesView(index: index),
          ),
        );
      },
      child: CircleAvatar(
        radius: 32.0,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(story.mediaUrl),
      ),
    );
  }
}
