import 'package:flutter/painting.dart';

const bankCards = [
  BankCardModel(
    type: 'Platinum',
    balance: 389073.56,
    validThru: '10/24',
    provider: 'mc',
    numbers: '*** 0212',
    color: Color(0xffF93E25),
  ),
  BankCardModel(
    type: 'Premium',
    balance: 674213.39,
    validThru: '11/25',
    provider: 'mc',
    numbers: '*** 4512',
    color: Color(0xff2567F9),
  ),
];

class BankCardModel {
  final String type;
  final double balance;
  final String validThru;
  final String provider;
  final String numbers;
  final Color color;

  const BankCardModel({
    required this.type,
    required this.balance,
    required this.validThru,
    required this.provider,
    required this.numbers,
    required this.color,
  });
}
