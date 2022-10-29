import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slidable_bank_cards/src/models/payment_history_model.dart';

class PaymentHistoryItem extends StatelessWidget {
  final PaymentHistoryModel payment;

  const PaymentHistoryItem(this.payment, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.0,
      child: Row(
        children: [
          SvgPicture.asset(payment.iconAssetPath),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payment.label,
                  style: const TextStyle(
                    fontSize: 14.0,
                    height: 20 / 14,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${payment.transactionsCount} transactions',
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 20 / 14,
                    color: Colors.white.withOpacity(.6),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${payment.amount} AZN',
                style: const TextStyle(
                  fontSize: 14.0,
                  height: 20 / 14,
                  color: Colors.white,
                ),
              ),
              Text(
                '${payment.percentage}\$',
                style: TextStyle(
                  fontSize: 14.0,
                  height: 20 / 14,
                  color: Colors.white.withOpacity(.6),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
