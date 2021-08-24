import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/transaction_form.dart';
import './widgets/transaction_screen.dart';
import 'widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final title = "Personal Expenses App";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(id: 1, title: 'Clothes', amount: 48.99),
    Transaction(id: 2, title: 'Food', amount: 85.42),
    Transaction(id: 3, title: 'Holiday', amount: 320.75),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openModal(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TransactionList(_transactions, _deleteTx),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openModal(context),
      ),
    );
  }

  void _submitTx(String title, double amount) {
    setState(() {
      int id = (_transactions.length == 0) ? 1 : _transactions.last.id + 1;

      _transactions.add(Transaction(id: id, title: title, amount: amount));
    });
  }

  void _deleteTx(int id) {
    setState(() {
      Transaction t = _transactions.firstWhere((e) => e.id == id);
      _transactions.remove(t);
    });
  }

  void _openModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return new TransactionForm(_submitTx);
        });
  }
}
