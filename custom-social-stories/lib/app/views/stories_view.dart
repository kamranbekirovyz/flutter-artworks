import 'dart:io';

import 'package:app/app/data/models/story.dart';
import 'package:app/app/data/stories.dart';
import 'package:app/app/utilities/theme_globals.dart';
import 'package:app/app/widgets/animated_bar.dart';
import 'package:app/app/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StoriesView extends StatefulWidget {
  final int index;

  const StoriesView({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  StoriesViewState createState() => StoriesViewState();
}

class StoriesViewState extends State<StoriesView> with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _animationController;
  late final VideoPlayerController? _videoPlayerController;

  late int _currentIndex;
  bool _videoReady = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
    _pageController = PageController(initialPage: widget.index);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _prepareContentForIndex(widget.index);

    _animationController.addListener(() {
      if (_animationController.value.toInt() == 1) {
        if (_pageController.page! < stories.length - 1) {
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
    final story = stories.elementAt(index);

    if (story.isVideo) {
      _stopAndResetAnimation();
      setState(() => _videoReady = false);
      await _videoPlayerController?.dispose();
      _videoPlayerController = VideoPlayerController.network(story.mediaUrl);
      await _videoPlayerController?.initialize();
      final duration = _videoPlayerController?.value.duration;
      _animationController.duration = duration;

      await _videoPlayerController?.play();
      setState(() => _videoReady = true);
    } else {
      _stopAndResetAnimation();
      _animationController.duration = const Duration(seconds: 5);
    }
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
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final indicatorTopPadding_ = Platform.isIOS ? MediaQuery.of(context).padding.top + 12 : 40.0;

    return GestureDetector(
      onLongPressStart: (_) {
        _animationController.stop();
        _videoPlayerController?.pause();
      },
      onLongPressEnd: (_) {
        _animationController.forward();
        _videoPlayerController?.play();
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
              itemCount: stories.length,
              itemBuilder: (_, int index) {
                final story = stories.elementAt(index);
                final isVideo = story.isVideo;

                return Stack(
                  children: [
                    Positioned.fill(
                      child: isVideo
                          ? AnimatedSwitcher(
                              duration: kThemeAnimationDuration,
                              child: Container(
                                key: Key('$_videoReady'),
                                child: _videoReady
                                    ? Center(
                                        child: AspectRatio(
                                          aspectRatio: _videoPlayerController!.value.aspectRatio,
                                          child: VideoPlayer(_videoPlayerController!),
                                        ),
                                      )
                                    : const CircularProgressIndicator(),
                              ),
                            )
                          : CachedImage(url: story.mediaUrl),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: _buildRight(index),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: _buildLeft(index),
                    ),
                    if (!isVideo)
                      Positioned(
                        child: _buildWhiteOverlay(),
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
        if (index < stories.length - 1) {
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
      children: stories
          .asMap()
          .map(
            (int key, Story value) {
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

  Widget _buildWhiteOverlay() {
    return Container(
      height: 250.0,
      width: double.maxFinite,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            // Colors.black54.withOpacity(1.0),
            Colors.black54.withOpacity(.8),
            Colors.black54.withOpacity(.6),
            // Colors.black54.withOpacity(.8),
            Colors.black54.withOpacity(.4),
            Colors.black54.withOpacity(.2),
            // Colors.black54.withOpacity(.6),
            Colors.black54.withOpacity(.0),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildOverlay(Story story) {
    final width = MediaQuery.of(context).size.width;

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
