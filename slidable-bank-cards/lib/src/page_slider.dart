import 'dart:math';

import 'package:flutter/material.dart';

class PageSlider extends StatefulWidget {
  final List<Widget> cards;

  const PageSlider(
    this.cards, {
    super.key,
  });

  @override
  State<PageSlider> createState() => _PageSliderState();
}

class _PageSliderState extends State<PageSlider> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      viewportFraction: 0.77,
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      padEnds: false,
      controller: _pageController,
      clipBehavior: Clip.none,
      itemCount: widget.cards.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final bankCard = widget.cards.elementAt(index);
        final isFirst = index == 0;
        final isLast = index == widget.cards.length - 1;

        return Padding(
          padding: EdgeInsets.only(
            left: isFirst ? 16.0 : 0.0,
            right: isLast ? 16.0 : 0.0,
          ),
          child: AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1.0;

              if (_pageController.position.haveDimensions) {
                value = _pageController.page! - index;

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
              var position = _pageController.position;
              if (position.hasPixels && position.hasContentDimensions) {
                var _page = _pageController.page;
                if (_page != null) {
                  itemOffset = _page - index;
                }
              } else {
                BuildContext storageContext = _pageController.position.context.storageContext;
                final double? previousSavedPosition = PageStorage.of(storageContext)?.readState(storageContext) as double?;
                if (previousSavedPosition != null) {
                  itemOffset = previousSavedPosition - index.toDouble();
                } else {
                  itemOffset = _pageController.page! - index.toDouble();
                }
              }

              final distortionRatio = (1 - (itemOffset.abs() * 0.375)).clamp(0.0, 1.0);
              final distortionValue = Curves.easeOut.transform(distortionRatio);

              return Transform.scale(
                // duration: const Duration(milliseconds: 50),
                scale: _pageController.page! < index ? distortionValue : 1.0,
                child: Container(
                  // duration: kThemeAnimationDuration,
                  transform: Matrix4.translationValues(0.0, (1 - distortionRatio) * 40, 0.0),
                  alignment: Alignment.center,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..rotateZ(
                        _pageController.page! > index ? value : 0.0,
                      ),
                    alignment: Alignment.center,
                    child: child,
                  ),
                ),
              );
            },
            child: bankCard,
          ),
        );
      },
    );
  }
}
