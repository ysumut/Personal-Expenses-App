import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final Function(String, double) submitTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  TransactionForm(this.submitTx);

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
    String title = titleController.text;
    double amount = double.parse(amountController.text);

    if(title.isEmpty || amount <= 0) return;

    submitTx(title, amount);
  }
}
