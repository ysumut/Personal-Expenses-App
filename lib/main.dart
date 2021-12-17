import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/chart_screen.dart';
import './widgets/transaction_form.dart';
import './widgets/transaction_list.dart';

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
          primarySwatch: Colors.purple,
          accentColor: Colors.blue,
          fontFamily: 'OpenSans'),
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
  final List<Transaction> _transactions = [];

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(widget.title),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openModal(context),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: _appScreen(appBar),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openModal(context),
      ),
    );
  }

  void _submitTx(Transaction newTx) {
    setState(() {
      if (_transactions.isEmpty) {
        newTx.id = 1;
      } else {
        int maxId = _transactions.reduce((a, b) => a.id > b.id ? a : b).id;
        newTx.id = maxId + 1;
      }

      _transactions.insert(0, newTx);
    });
  }

  void _editTx(Transaction newTx) {
    setState(() {
      Transaction oldTx = _transactions.firstWhere((e) => e.id == newTx.id);
      oldTx.title = newTx.title;
      oldTx.amount = newTx.amount;
      oldTx.dateTime = newTx.dateTime;
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
      },
    );
  }

  _appScreen(AppBar appBar) {
    if (_transactions.length == 0) {
      return Container(
        height: 580,
        margin: EdgeInsets.all(40),
        child: Image.asset(
          'assets/images/waiting.png',
          fit: BoxFit.cover,
        ),
      );
    } else {
      double height = MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top -
          appBar.preferredSize.height;

      return Column(
        children: [
          Container(
            height: height * 0.3,
            child: ChartScreen(_getLastWeekTransactions),
          ),
          Container(
            height: height * 0.7,
            child: TransactionList(_transactions, _editTx, _deleteTx),
          ),
        ],
      );
    }
  }

  List<Transaction> get _getLastWeekTransactions {
    return _transactions
        .where((e) =>
            e.dateTime.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }
}
