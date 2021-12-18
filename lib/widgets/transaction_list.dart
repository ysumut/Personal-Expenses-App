import 'package:flutter/material.dart';
import 'package:personal_expenses_app/widgets/transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function(Transaction) _editTx;
  final Function(int) _deleteTx;

  TransactionList(this._transactions, this._editTx, this._deleteTx);

  @override
  Widget build(BuildContext context) {
    _transactions.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 1 : 0);

    return ListView(
      children: _transactions
          .map((tx) => TransactionItem(
                tx,
                _editTx,
                _deleteTx,
                key: ValueKey(tx.id),
              ))
          .toList(),
    );
  }
}
