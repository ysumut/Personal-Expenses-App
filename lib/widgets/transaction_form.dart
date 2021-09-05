import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function(String, double, DateTime) submitTx;

  TransactionForm(this.submitTx);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String errMsg = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => _saveData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _saveData(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Picked Date: ' +
                      DateFormat('dd/MM/yyyy').format(_selectedDate)),
                  TextButton.icon(
                    label: Text('Pick'),
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
                errMsg,
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ),
      ),
    );
  }

  void _saveData() {
    try {
      String title = titleController.text.trim();
      double amount = double.parse(amountController.text.trim());

      if (title.isEmpty || amount <= 0 || amount > 999999999) {
        setState(() {
          errMsg =
              'Başlık boş olamaz, miktar 0 dan küçük veya 999999999\'dan büyük olamaz!';
        });
        return;
      }

      widget.submitTx(title, amount, this._selectedDate);
      Navigator.of(context).pop();
    } catch (err) {
      setState(() {
        errMsg = 'Hatalı kayıt!';
      });
    }
  }

  void openDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
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
