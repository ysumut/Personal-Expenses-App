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
    return Container(
        height: 580,
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (ctx, index) {
            return Card(
              elevation: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 70,
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
                        '\$' + NumberFormat("#,##0.00").format(transactions[index].amount),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    width: 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(transactions[index].title,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Text(
                            DateFormat.yMMMEd()
                                .format(transactions[index].dateTime),
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => deleteTx(transactions[index].id),
                        icon: Icon(
                          Icons.delete,
                          size: 20,
                        ),
                        label: Text(
                          'Delete',
                          style: TextStyle(fontSize: 12),
                        ),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.redAccent),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }
}
