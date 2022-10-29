import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slidable_bank_cards/src/models/action_button_model.dart';

class ActionButton extends StatelessWidget {
  final ActionButtonModel actionButton;

  const ActionButton(this.actionButton, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: const Color.fromRGBO(20, 28, 71, 1.0),
          ),
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              actionButton.iconAssetPath,
            ),
            const SizedBox(height: 8.0),
            Text(
              actionButton.label,
              style: const TextStyle(
                fontSize: 12.0,
                height: 16 / 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
