import 'package:app/app/utilities/theme_globals.dart';
import 'package:app/app/widgets/stories_list.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: primaryColor,
        title: const Text('Stories'),
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: StoriesList(),
      ),
    );
  }
}
