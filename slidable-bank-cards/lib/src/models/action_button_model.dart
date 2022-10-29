const actionButtons = [
  ActionButtonModel(
    iconAssetPath: 'assets/card-to-card.svg',
    label: 'Card to card',
  ),
  ActionButtonModel(
    iconAssetPath: 'assets/payments.svg',
    label: 'Pay',
  ),
  ActionButtonModel(
    iconAssetPath: 'assets/scan-qr.svg',
    label: 'Scan QR',
  ),
];

class ActionButtonModel {
  final String iconAssetPath;
  final String label;

  const ActionButtonModel({
    required this.iconAssetPath,
    required this.label,
  });
}
