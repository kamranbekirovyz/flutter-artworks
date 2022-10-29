import 'dart:math';

import 'package:flutter/material.dart';

class PageSlider extends StatelessWidget {
  final PageController pageController;
  final List<Widget> children;

  const PageSlider({
    required this.pageController,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      padEnds: false,
      controller: pageController,
      clipBehavior: Clip.none,
      itemCount: children.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final child_ = children.elementAt(index);

        return Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: AnimatedBuilder(
            animation: pageController,
            builder: (context, child) {
              double value = 1.0;

              if (pageController.hasClients && pageController.position.hasContentDimensions) {
                value = pageController.page! - index;

                if (value >= 0) {
                  double lowerLimit_ = 0.1;
                  double upperLimit_ = pi / 2;

                  value = (upperLimit_ - (value.abs() * (upperLimit_ - lowerLimit_))).clamp(
                    lowerLimit_,
                    upperLimit_,
                  );
                  value = upperLimit_ - value;
                  value *= -1;
                }
              }

              double itemOffset = 0;
              final page = pageController.position.hasContentDimensions ? pageController.page! : 0.0;

              if (pageController.position.hasContentDimensions && pageController.position.hasPixels) {
                var page_ = pageController.page;
                if (page_ != null) {
                  itemOffset = page_ - index;
                }
              } else {
                BuildContext storageContext = pageController.position.context.storageContext;
                final double? previousSavedPosition = PageStorage.of(storageContext)?.readState(storageContext) as double?;
                if (previousSavedPosition != null) {
                  itemOffset = previousSavedPosition - index.toDouble();
                } else {
                  itemOffset = page - index.toDouble();
                }
              }

              final distortionRatio = (1 - (itemOffset.abs() * 0.375)).clamp(0.0, 1.0);
              final distortionValue = Curves.easeOut.transform(distortionRatio);

              return Transform.scale(
                scale: page < index ? distortionValue : 1.0,
                child: Container(
                  transform: Matrix4.translationValues(
                    -(1 - distortionRatio) * 45,
                    (1 - distortionRatio) * 45,
                    0.0,
                  ),
                  alignment: Alignment.center,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..rotateZ(
                        page > index ? value : 0.0,
                      ),
                    alignment: Alignment.center,
                    child: child,
                  ),
                ),
              );
            },
            child: child_,
          ),
        );
      },
    );
  }
}
