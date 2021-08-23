import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final Function(String, String) submitTx;
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
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
            ElevatedButton.icon(
              onPressed: () => submitTx(titleController.text, amountController.text),
              label: Text('Submit'),
              icon: Icon(Icons.save),
            )
          ],
        ),
      ),
    );
  }
}
