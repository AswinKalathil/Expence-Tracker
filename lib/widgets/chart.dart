import 'chartBar.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalAmount += recentTransaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (prevVal, element) {
      return prevVal + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
          margin: EdgeInsets.all(15),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: constraints.maxHeight * .122,
                    child: Row(
                      children: [
                        Text(
                          'Last Week ',
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                        ),
                        Text(
                          '₹ ${totalSpending.toString()} ',
                          style: TextStyle(fontSize:  constraints.maxHeight * .122),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        0, constraints.maxHeight * .06, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: groupedTransactionValues.map((data) {
                        return Container(
                          height: constraints.maxHeight * .817,
                          child: ChartBar(
                              data['day'],
                              data['amount'],
                              totalSpending == 0
                                  ? 0.0
                                  : ((data['amount'] as double) /
                                      totalSpending)),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}
