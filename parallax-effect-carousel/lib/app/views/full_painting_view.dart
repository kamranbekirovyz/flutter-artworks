import 'package:app/app/data/painting.dart';
import 'package:app/app/widgets/magical_hero.dart';
import 'package:flutter/material.dart';

class FullPaintingView extends StatelessWidget {
  final Painting painting;

  const FullPaintingView(this.painting, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        body: Stack(
          children: [
            Positioned.fill(
              child: _buildDarkBackground(),
            ),
            Align(
              alignment: Alignment.center,
              child: _buildImage(),
            ),
            Positioned(
              bottom: 120.0,
              left: 0.0,
              right: 0.0,
              child: Center(
                child: _buildText(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDarkBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(painting.assetPath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.grey.shade900, BlendMode.modulate),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return MagicalHero(
      tag: '${painting.hashCode}-image',
      child: Image.asset(painting.assetPath),
    );
  }

  Widget _buildText() {
    return MagicalHero(
      tag: '${painting.hashCode}-name',
      child: Text(
        painting.name,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
