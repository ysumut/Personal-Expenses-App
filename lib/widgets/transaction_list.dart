import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(int) deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Column(children: transactions.map((e) {
      return Card(
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 3),
                  borderRadius: BorderRadius.circular(20)),
              child: Text('\$' + e.amount.toString()),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(e.title, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(DateFormat().format(e.dateTime),
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () => deleteTx(e.id),
                  icon: Icon(Icons.delete, size: 20,),
                  label: Text('Delete', style: TextStyle(fontSize: 12),),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                )
              ],
            ),
          ],
        ),
      );
    }).toList());
  }
}
