import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slidable_bank_cards/src/models/bank_card_model.dart';

class BankCardItem extends StatelessWidget {
  final BankCardModel bankCard;

  const BankCardItem(
    this.bankCard, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        color: bankCard.color,
        height: 144.0,
        child: Stack(
          children: [
            Positioned(
              left: 160.0,
              bottom: -38.0,
              top: -16.0,
              child: Opacity(
                opacity: 0.33,
                child: Image.asset(
                  'assets/card-background.png',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bankCard.type,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          height: 24 / 16,
                        ),
                      ),
                      Center(
                        child: SvgPicture.asset(
                          'assets/${bankCard.provider}.svg',
                          width: 46.0,
                          height: 26.0,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '\$${bankCard.balance}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 24 / 16,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bankCard.validThru,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          height: 24 / 12,
                        ),
                      ),
                      Text(
                        bankCard.numbers,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          height: 24 / 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
