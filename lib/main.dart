// ignore_for_file: deprecated_member_use

import 'package:expence_tracker/widgets/newTransaction.dart';
import 'package:expence_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './widgets/chart.dart';
import 'model/transaction.dart';

final primaryViolet = MaterialColor(
  0xFF6F00F8,
  <int, Color>{
    50: Color(0xFFF3E5F9),
    100: Color(0xFFE0C8F2),
    200: Color(0xFFC6A6E9),
    300: Color(0xFFAB84E0),
    400: Color(0xFF9569D9),
    500: Color(0xFF7F4ED2),
    600: Color(0xFF7448CD),
    700: Color(0xFF683FC8),
    800: Color(0xFF5D37C3),
    900: Color(0xFF4626BA),
  },
);
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
          primarySwatch: primaryViolet,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> get _recentTransaction {
    return _usrTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  final List<Transaction> _usrTransactions = [
    Transaction(id: 't1', title: 'Shoes', amount: 806, date: DateTime.now()),
    Transaction(id: 't2', title: 'Bag', amount: 506, date: DateTime.now()),
    Transaction(id: 't1', title: 'Shoes', amount: 806, date: DateTime.now()),
    Transaction(id: 't2', title: 'Bag', amount: 506, date: DateTime.now()),
  ];

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: Newtransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _addNewTransaction(String txtitle, String strAmount) {
    final Transaction newTx = Transaction(
      title: txtitle,
      amount: double.parse(strAmount),
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _usrTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expences',
          style: Theme.of(context).appBarTheme.textTheme.headline6,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_rounded),
            onPressed: (() => startAddNewTransaction(context)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Chart(_recentTransaction),
              TransactionList(_usrTransactions),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_rounded),
        onPressed: (() => startAddNewTransaction(context)),
      ),
    );
  }
}
