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


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //TransactionForm(_submitTx),
        //TransactionList(_transactions, _deleteTx),
      ],
    );
  }
}
