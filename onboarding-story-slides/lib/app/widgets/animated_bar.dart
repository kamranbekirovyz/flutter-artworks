import 'package:app/app/utilities/theme_globals.dart';
import 'package:flutter/material.dart';

class AnimatedBar extends StatelessWidget {
  final AnimationController animationController;
  final int position;
  final int currentIndex;
  final bool seen;

  const AnimatedBar({
    Key? key,
    required this.animationController,
    required this.position,
    required this.currentIndex,
    required this.seen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final current = position == currentIndex;

            return Stack(
              children: <Widget>[
                _buildLine(double.infinity, otherIndicatorColor),
                current
                    ? AnimatedBuilder(
                        animation: animationController,
                        builder: (context, child) {
                          return _buildLine(
                            constraints.maxWidth * animationController.value,
                            animatingIndicatorColor,
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLine(double width, Color color) {
    return Container(
      height: 5.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
