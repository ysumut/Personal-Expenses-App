class Transaction {
  final int id;
  final String title;
  final double amount;
  final DateTime dateTime = DateTime.now();

  Transaction({required this.id, required this.title, required this.amount});
}
