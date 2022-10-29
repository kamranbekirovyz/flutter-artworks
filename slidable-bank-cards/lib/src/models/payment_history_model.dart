const paymentHistoryList = [
  PaymentHistoryModel(
    iconAssetPath: 'assets/housing.svg',
    label: 'Housing',
    transactionsCount: 10,
    amount: 953.12,
    percentage: 15,
  ),
  PaymentHistoryModel(
    iconAssetPath: 'assets/communication.svg',
    label: 'Communication',
    transactionsCount: 75,
    amount: 3374.00,
    percentage: 35,
  ),
  PaymentHistoryModel(
    iconAssetPath: 'assets/taxes-fines.svg',
    label: 'Taxes & Fines',
    transactionsCount: 400,
    amount: 224.00,
    percentage: 10,
  ),
  PaymentHistoryModel(
    iconAssetPath: 'assets/banking-loans.svg',
    label: 'Banking & Loans',
    transactionsCount: 50,
    amount: 323.42,
    percentage: 10,
  ),
  PaymentHistoryModel(
    iconAssetPath: 'assets/foods-beverages.svg',
    label: 'Food & Beverages',
    transactionsCount: 50,
    amount: 323.42,
    percentage: 1,
  ),
];

class PaymentHistoryModel {
  final String iconAssetPath;
  final String label;
  final int transactionsCount;
  final double amount;
  final double percentage;

  const PaymentHistoryModel({
    required this.iconAssetPath,
    required this.label,
    required this.transactionsCount,
    required this.amount,
    required this.percentage,
  });
}
