import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/transaction_form.dart';

class TransactionItem extends StatefulWidget {
  final Transaction _transaction;
  final Function(Transaction) _editTx;
  final Function(int) _deleteTx;

  const TransactionItem(this._transaction, this._editTx, this._deleteTx,
      {Key? key})
      : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  Widget build(BuildContext context) {
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
                border:
                    Border.all(color: Theme.of(context).accentColor, width: 3),
                borderRadius: BorderRadius.circular(15)),
            child: FittedBox(
              child: Text(
                '\$' +
                    NumberFormat("#,##0.00").format(widget._transaction.amount),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(widget._transaction.title,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Text(DateFormat.yMMMEd().format(widget._transaction.dateTime),
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () =>
                    _openModalForEdit(context, widget._transaction),
                icon: Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: () => widget._deleteTx(widget._transaction.id),
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
  }

  void _openModalForEdit(BuildContext context, Transaction t) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return new TransactionForm(
          widget._editTx,
          transaction: t,
        );
      },
    );
  }
}
