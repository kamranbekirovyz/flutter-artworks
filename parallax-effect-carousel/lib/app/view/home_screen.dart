import 'package:app/app/data/paintings_list.dart';
import 'package:app/app/view/painting_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;

  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.7,
    )..addListener(() {
        setState(() {
          _currentPage = _pageController.page ?? 0;
        });
      });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Material(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage(
                'assets/images/background.jpg',
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.grey.shade300,
                BlendMode.modulate,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTop(),
              _buildBottom(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24.0),
          child: Text(
            'Highlight Paintings',
            style: TextStyle(
              fontFamily: 'Times-Bold',
              fontSize: 24.0,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 24.0),
        SizedBox(
          height: 320.0,
          child: PageView.builder(
            controller: _pageController,
            itemCount: paintings.length,
            itemBuilder: (_, int index) {
              final painting = paintings.elementAt(index);

              return Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: PaintingItem(
                  painting,
                  currentPage: _currentPage,
                  index: index,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 56.0),
      ],
    );
  }

  Widget _buildTop() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Text(
            'Vincent\nvan Gogh',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Times-Bold',
              fontSize: 50,
              letterSpacing: 2,
              height: 64 / 50,
            ),
          ),
          const SizedBox(height: 24.0),
          Text(
            '30 March 1853-29 July 1890',
            style: GoogleFonts.gentiumBookBasic(
              color: Colors.white,
              fontSize: 24.0,
              height: 32 / 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Vincent Willem van Gogh was a Dutch post-impressionist painter who posthumously became one of the most famous and influential figures in the history of Western art.',
            style: GoogleFonts.gentiumBookBasic(
              color: Colors.white.withOpacity(.9),
              fontSize: 16.0,
              height: 20 / 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
