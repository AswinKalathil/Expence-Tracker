import 'package:flutter/material.dart';

class Newtransaction extends StatelessWidget {
  final Function addtx;

  Newtransaction(this.addtx);
  final titleController = TextEditingController();
  final amountController = TextEditingController();
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
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),
            FlatButton(
              child: Text('Add Transacion'),
              onPressed: () {
                addtx(
                    titleController.text, amountController.text);
              },
              textColor: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
