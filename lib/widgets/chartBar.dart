import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPct;

  ChartBar(this.label, this.spendingAmount, this.spendingPct);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      return Column(
        children: <Widget>[
          Container(
            width: 40,
            height: constraints.maxHeight * .112,
            child: FittedBox(
              child: Text(
                '₹${spendingAmount.toStringAsFixed(0)}',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * .03,
          ),
          Container(
            height: constraints.maxHeight * .74,
            width: 20,
            child: Stack(alignment: Alignment.bottomCenter, children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 0),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(4))),
              ),
              FractionallySizedBox(
                heightFactor: spendingPct,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(4), bottom: Radius.zero),
                  ),
                ),
              )
            ]),
          ),
          Container(
              height: constraints.maxHeight * .112,
              child: FittedBox(child: Text('${label}')))
        ],
      );
    }));
  }
}
