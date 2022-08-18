import 'package:app/app/data/models/story.dart';
import 'package:app/app/data/stories.dart';
import 'package:app/app/widgets/story_item.dart';
import 'package:flutter/material.dart';

class StoriesList extends StatelessWidget {
  const StoriesList({
    Key? key,
  }) : super(key: key);

  List<Story> get _stories => stories;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      color: Theme.of(context).canvasColor,
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: _buildStoriesList(),
    );
  }

  Widget _buildStoriesList() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: _stories.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, int index) {
        final story = stories.elementAt(index);
        final isFirst = index == 0;
        final isLast = index == stories.length - 1;

        return Padding(
          padding: EdgeInsets.only(
            left: isFirst ? 16.0 : 0.0,
            right: isLast ? 16.0 : 0.0,
          ),
          child: StoryItem(story, index: index),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(width: 8.0),
    );
  }
}
