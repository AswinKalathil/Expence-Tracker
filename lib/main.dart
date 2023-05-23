// ignore_for_file: deprecated_member_use

import 'package:expence_tracker/widgets/newTransaction.dart';
import 'package:expence_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
              button: TextStyle(color: Colors.white)),
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
      debugShowCheckedModeBanner: false,
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
    Transaction(
      id: 't3',
      title: 'Jacket',
      amount: 1000,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
    Transaction(
      id: 't4',
      title: 'Groceries',
      amount: 250,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: 't5',
      title: 'Gas',
      amount: 2000,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't6',
      title: 'Phone Bill',
      amount: 1200,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't7',
      title: 'Electricity Bill',
      amount: 150,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't8',
      title: 'Internet Bill',
      amount: 500,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
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

  void _addNewTransaction(
      String txtitle, String strAmount, DateTime ChoosenDate) {
    final Transaction newTx = Transaction(
      title: txtitle,
      amount: double.parse(strAmount),
      date: ChoosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _usrTransactions.add(newTx);
    });
  }

  Future<void> _confirmDelete(String id) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Confirm Delete',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    _deleteTransaction(id);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ))
            ],
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _usrTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool islandScape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        'Expenses',
        style: Theme.of(context).appBarTheme.textTheme.headline6,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add_rounded),
          onPressed: (() => startAddNewTransaction(context)),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (!islandScape)
                Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        .37,
                    child: Chart(_recentTransaction)),
              if (!islandScape)
                Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        .63,
                    child: TransactionList(_usrTransactions, _confirmDelete)),
              if (islandScape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Show Chart'),
                    Switch(
                      value: _showChart,
                      onChanged: ((value) {
                        setState(() {
                          _showChart = value;
                        });
                      }),
                    ),
                  ],
                ),
              if (islandScape)
                _showChart
                    ? Container(
                        height: (mediaQuery.size.height -
                                appBar.preferredSize.height -
                                mediaQuery.padding.top) *
                            .8,
                        child: Chart(_recentTransaction))
                    : Container(
                        height: (mediaQuery.size.height -
                                appBar.preferredSize.height -
                                mediaQuery.padding.top) *
                            .82,
                        child:
                            TransactionList(_usrTransactions, _confirmDelete)),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_rounded),
        onPressed: (() => startAddNewTransaction(context)),
      ),
    );
  }
}
