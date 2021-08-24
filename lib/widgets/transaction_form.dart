import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final Function(String, double) submitTx;

  TransactionForm(this.submitTx);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
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
            ElevatedButton.icon(
              label: Text('Submit'),
              icon: Icon(Icons.save),
              onPressed: _saveData,
            )
          ],
        ),
      ),
    );
  }

  void _saveData() {
    try {
      String title = titleController.text.trim();
      double amount = double.parse(amountController.text.trim());

      if (title.isEmpty || amount <= 0 || amount > 999999999) return;

      widget.submitTx(title, amount);
      Navigator.of(context).pop();
    }
    catch(err) {
      print(err);
    }
  }
}
