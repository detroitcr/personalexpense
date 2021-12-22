import 'package:flutter/material.dart';
import 'transaction_list.dart';
import 'chart.dart';
import 'user_transaction.dart';
import 'new_transaction.dart';
import 'package:personalexpense/models/transaction.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctofTotal;

  ChartBar(this.label,this.spendingAmount,this.spendingPctofTotal);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 20,
        child: FittedBox(child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
        ),
      ),
      SizedBox(
        height: 4,
      ),
      Container(
        width: 10,
        height: 60,
        // stack widget allow elements top of each other like 3d
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey,
                width: 1,
                ),
                color: Color.fromRGBO(220, 220, 220,1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
              FractionallySizedBox(
                heightFactor: spendingPctofTotal,
                child: Container(
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
          ],
        ),
      ),
      SizedBox(
        height: 4,
      ),
      Text(label),
    ],);
  }
}
