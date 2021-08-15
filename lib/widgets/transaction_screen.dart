import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_form.dart';
import './transaction_list.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final List<Transaction> _transactions = [
    Transaction(id: 1, title: 'Clothes', amount: 48.99),
    Transaction(id: 2, title: 'Food', amount: 85.42),
    Transaction(id: 3, title: 'Holiday', amount: 320.75),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionList(_transactions, _deleteTx),
        TransactionForm(_submitTx),
      ],
    );
  }

  void _submitTx(String title, String amount) {
    setState(() {
      int id = (_transactions.length == 0) ? 1 : _transactions.last.id + 1;

      _transactions.add(
        Transaction(id: id, title: title, amount: double.parse(amount))
      );
    });
  }

  void _deleteTx(int id) {
    setState(() {
      Transaction t = _transactions.firstWhere((e) => e.id == id);
      _transactions.remove(t);
    });
  }
}
