import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slidable_bank_cards/src/action_button.dart';
import 'package:slidable_bank_cards/src/bank_card_item.dart';
import 'package:slidable_bank_cards/src/models/action_button_model.dart';
import 'package:slidable_bank_cards/src/models/bank_card_model.dart';
import 'package:slidable_bank_cards/src/models/payment_history_model.dart';
import 'package:slidable_bank_cards/src/page_slider.dart';
import 'package:slidable_bank_cards/src/payment_history_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: _buildAppBar(),
      extendBodyBehindAppBar: true,
      body: Stack(
        clipBehavior: Clip.none,
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
            height: statusBarHeight + 336.0,
            child: PageSlider(
              bankCards.map((e) => BankCardItem(e)).toList(),
            ),
          ),
          Positioned(
            top: statusBarHeight + 232.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 24.0,
              ),
              decoration: const BoxDecoration(
                color: Color(0xff121433),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              width: double.maxFinite,
              height: screenHeight - statusBarHeight + 264.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: actionButtons.map((ActionButtonModel e) {
                      return ActionButton(e);
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12.0),
                        const Text(
                          'Payment history',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            height: 24 / 16,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        _buildDivider(),
                        ...paymentHistoryList.map((PaymentHistoryModel e) {
                          return Column(
                            children: [
                              PaymentHistoryItem(e),
                              _buildDivider(),
                            ],
                          );
                        }).toList(),
                        _buildDivider(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1.0,
      color: Color.fromRGBO(33, 37, 91, 1.0),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
    );
  }
}
