// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Newtransaction extends StatefulWidget {
  final Function addtx;

  Newtransaction(this.addtx);

  @override
  State<Newtransaction> createState() => _NewtransactionState();
}

class _NewtransactionState extends State<Newtransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  late DateTime _selectedDate = DateTime.now();
  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == Null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate!;
      });
    });
  }

  void _submitData() {
    final enterdTitle = _titleController.text;
    final enterdAmount = double.tryParse(_amountController.text);
    if (enterdTitle.isEmpty || enterdAmount == null || enterdAmount <= 0) {
      return;
    }

    widget.addtx(_titleController.text, _amountController.text,
        _selectedDate == null ? DateTime.now() : _selectedDate);
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
              controller: _titleController,
              onSubmitted: (_) {
                _submitData();
              },
            ),
            TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) {
                  _submitData();
                }),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(_selectedDate == null
                        ? 'Today'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                  ),
                  TextButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            ElevatedButton(
              // child: Theme.of(context).primaryColor,
              child: Text(
                'Add Transacion',
                style: Theme.of(context).textTheme.button,
              ),
              onPressed: _submitData,
              // textColor: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
