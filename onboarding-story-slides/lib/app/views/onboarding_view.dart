import 'dart:io';

import 'package:app/app/models/story.dart';
import 'package:app/app/data/slides.dart';
import 'package:app/app/utilities/theme_globals.dart';
import 'package:app/app/widgets/animated_bar.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({
    Key? key,
  }) : super(key: key);

  @override
  OnboardingViewState createState() => OnboardingViewState();
}

class OnboardingViewState extends State<OnboardingView> with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _animationController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 50),
    );

    _prepareContentForIndex(0);

    _animationController.addListener(() {
      if (_animationController.value.toInt() == 1) {
        if (_pageController.page! < slides.length - 1) {
          // lightImpactFeedback();
          _pageController.jumpToPage(_currentIndex + 1);
        } else {
          Navigator.of(context).maybePop();
        }
      }
    });
    // _animationController.forward();

    // _pageController.addListener(() async {

    // });
  }

  Future<void> _prepareContentForIndex(int index) async {
    _stopAndResetAnimation();
    _animationController.duration = const Duration(seconds: 50);
    _restartAnimation();

    setState(() {});
  }

  void _restartAnimation() {
    _animationController.forward();
  }

  void _stopAndResetAnimation() {
    _animationController.stop();
    _animationController.reset();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final indicatorTopPadding_ = Platform.isIOS ? MediaQuery.of(context).padding.top + 12 : 40.0;

    return GestureDetector(
      onLongPressStart: (_) {
        _animationController.stop();
      },
      onLongPressEnd: (_) {
        _animationController.forward();
      },
      child: Material(
        color: Colors.black,
        child: Stack(
          children: [
            PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (int index) {
                _currentIndex = index;
                _prepareContentForIndex(_currentIndex);
              },
              controller: _pageController,
              itemCount: slides.length,
              itemBuilder: (_, int index) {
                final story = slides.elementAt(index);

                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(story.media),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: _buildRight(index),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: _buildLeft(index),
                    ),
                    Positioned(
                      left: 20.0,
                      top: 32.0 + indicatorTopPadding_,
                      child: _buildOverlay(story),
                    ),
                  ],
                );
              },
            ),
            Positioned(
              top: indicatorTopPadding_,
              left: 10.0,
              right: 10.0,
              child: _buildIndicators(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeft(int index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (index > 0) {
          _pageController.animateToPage(
            index - 1,
            curve: Curves.ease,
            duration: kThemeAnimationDuration,
          );
        }
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width / 2,
      ),
    );
  }

  Widget _buildRight(int index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (index < slides.length - 1) {
          _pageController.nextPage(
            duration: kThemeAnimationDuration,
            curve: Curves.ease,
          );
        }
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width / 2,
      ),
    );
  }

  Widget _buildIndicators() {
    return Row(
      children: slides
          .asMap()
          .map(
            (int key, Slide value) {
              return MapEntry(
                key,
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return AnimatedBar(
                      animationController: _animationController,
                      position: key,
                      currentIndex: _currentIndex,
                      seen: _currentIndex < key,
                    );
                  },
                ),
              );
            },
          )
          .values
          .toList(),
    );
  }

  Widget _buildOverlay(Slide story) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '',
          style: TextStyle(
            fontSize: 18.0,
            color: welcomeColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        // Row(
        //   children: [
        //     Container(
        //       width: width - 72.0,
        //       padding: const EdgeInsets.only(top: 4.0),
        //       child: Text(story.title),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 12.0),
        // Text(story.subtitle)
      ],
    );
  }
}
