import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transaction_form.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function(Transaction) _editTx;
  final Function(int) _deleteTx;

  TransactionList(this._transactions, this._editTx, this._deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 580,
        child: ListView.builder(
          itemCount: _transactions.length,
          itemBuilder: (ctx, index) {
            return Card(
              elevation: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 100,
                    height: 35,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        border: Border.all(
                            color: Theme.of(context).accentColor, width: 3),
                        borderRadius: BorderRadius.circular(15)),
                    child: FittedBox(
                      child: Text(
                        '\$' +
                            NumberFormat("#,##0.00")
                                .format(_transactions[index].amount),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(_transactions[index].title,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Text(
                            DateFormat.yMMMEd()
                                .format(_transactions[index].dateTime),
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () =>
                            _openModalForEdit(context, _transactions[index]),
                        icon: Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _deleteTx(_transactions[index].id),
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }

  void _openModalForEdit(BuildContext context, Transaction t) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return new TransactionForm(
          _editTx,
          transaction: t,
        );
      },
    );
  }
}
