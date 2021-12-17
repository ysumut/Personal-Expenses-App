import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionForm extends StatefulWidget {
  final Function(Transaction) saveTx;
  final Transaction? transaction;

  TransactionForm(this.saveTx, {this.transaction});

  @override
  _TransactionFormState createState() =>
      _TransactionFormState(transaction: transaction);
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _errMsg = "";
  Transaction? transaction;

  _TransactionFormState({this.transaction}) {
    if (transaction != null) {
      _titleController.text = transaction!.title;
      _amountController.text = transaction!.amount.toStringAsFixed(2);
      _selectedDate = transaction!.dateTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          margin: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    label: Text(
                      DateFormat('dd/MM/yyyy').format(_selectedDate),
                      style: TextStyle(color: Colors.black),
                    ),
                    icon: Icon(Icons.date_range),
                    onPressed: openDatePicker,
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                label: Text('Submit'),
                icon: Icon(Icons.save),
                onPressed: _saveData,
              ),
              Container(
                  child: Text(
                _errMsg,
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ),
      ),
    );
  }

  void _saveData() {
    try {
      String title = _titleController.text.trim();
      double amount = double.parse(_amountController.text.trim());

      if (title.isEmpty ||
          title.length > 50 ||
          amount <= 0 ||
          amount > 999999999) {
        setState(() {
          _errMsg =
              'Başlık boş veya 50 karakterden büyük olamaz, miktar 0 dan küçük veya 999999999\'dan büyük olamaz!';
        });
        return;
      }

      int id = 0;
      if (widget.transaction != null) {
        id = widget.transaction!.id;
      }

      widget.saveTx(Transaction(
              id: id,
              title: title,
              amount: amount,
              dateTime: _selectedDate) // id will change in submitTx
          );
      Navigator.of(context).pop();
    } catch (err) {
      print("ERROR: " + err.toString());
      setState(() {
        _errMsg = 'Hatalı kayıt!';
      });
    }
  }

  void openDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) return;

      setState(() {
        _selectedDate = value;
      });
    });
  }
}
