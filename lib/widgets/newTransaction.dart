
import 'package:flutter/material.dart';

class Newtransaction extends StatefulWidget {
  final Function addtx;

  Newtransaction(this.addtx);

  @override
  State<Newtransaction> createState() => _NewtransactionState();
}

class _NewtransactionState extends State<Newtransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enterdTitle = titleController.text;
    final enterdAmount = double.tryParse(amountController.text);
    if (enterdTitle.isEmpty || enterdAmount == null || enterdAmount <= 0)
      return;

    widget.addtx(
      titleController.text,
      amountController.text,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) {
                submitData();
              },
            ),
            TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) {
                  submitData();
                }),
            FlatButton(
              child: Text('Add Transacion'),
              onPressed: submitData,
              textColor: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
