// ignore_for_file: deprecated_member_use

import 'package:expence_tracker/widgets/usrTransacion.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expences'),
      ),
      body: SingleChildScrollView(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: double.infinity,
                  height: 100,
                  child: Card(
                    color: Colors.blue,
                    elevation: 6,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            elevation: 5,
                            color: Colors.yellow,
                            child: Text('Chart1'),
                          ),
                          Card(
                            elevation: 5,
                            color: Colors.white,
                            child: Text('Chart2'),
                          )
                        ]),
                  )),
              UserTrasction(),
            ]),
      ),
    );
  }
}
