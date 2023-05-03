import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './widgets/newTransaction.dart';
import '../model/transaction.dart';

class UserTrasction extends StatefulWidget {
  @override
  State<UserTrasction> createState() => _UserTrasctionState();
}

class _UserTrasctionState extends State<UserTrasction> {
  final List<Transaction> _usrTransactions = [
    Transaction(id: 't1', title: 'Shoes', amount: 806, date: DateTime.now()),
    Transaction(id: 't2', title: 'Bag', amount: 506, date: DateTime.now()),
  ];

  void _addNewTransaction(String txtitle, String strAmount) {
    double txamount;
    try {
      txamount = double.parse(strAmount);
    } catch (e) {
      print("Error $e");
      txamount = 0;
    }

    final Transaction newTx = Transaction(
      title: txtitle,
      amount: txamount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _usrTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Newtransaction(_addNewTransaction),
        TransactionList(_usrTransactions),
      ],
    );
  }
}
