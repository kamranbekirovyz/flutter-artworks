import 'package:flutter/material.dart';

class MagicalHero extends StatelessWidget {
  final Widget child;
  final String tag;

  const MagicalHero({
    Key? key,
    required this.child,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(
        color: Colors.transparent,
        child: child,
      ),
    );
  }
}
