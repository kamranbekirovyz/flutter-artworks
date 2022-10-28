import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slidable_bank_cards/bank_card_model.dart';
import 'package:slidable_bank_cards/page_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Slidable Bank Cards',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          'Mobile bank',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            height: 24 / 16,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        actions: [
          SvgPicture.asset('assets/notifications.svg'),
          const SizedBox(width: 16.0),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            height: statusBarHeight + 320.0,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff75FFD6),
                  Color(0xff6663FF),
                ],
              ),
            ),
          ),
          SizedBox(
            height: statusBarHeight + 376.0,
            child: PageSlider(
              bankCards.map((e) => _buildCard(e)).toList(),
              initialPage: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BankCardModel bankCard) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: bankCard.color,
      ),
      width: double.maxFinite,
      height: 144.0,
    );
  }
}
