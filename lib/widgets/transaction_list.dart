import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personalexpense/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  // constructor so we declare the list of transactions
  TransactionList(this.transactions,this.deleteTx);

  //get i => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      // we use ListView instead of column so list are scrollable
      // Using ListView have two methods or ways this is first method
      //child: ListView(
      // second method ListView.builder
      child: transactions.isEmpty ? Column(
        children: [
          Text('No Transaction',
          style: Theme.of(context).textTheme.subtitle1),
           SizedBox(
             height: 10,
           ),
           Container(
             height: 200,
             child: Image.asset('assets/images/waiting.png',
             fit: BoxFit.cover,
             ),
           ),
        ],
      ) : ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 5 ,
            margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5,
                ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                      child: Text('\$${transactions[index].amount}')),
                ),
              ),
              title: Text(
                transactions[index].title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              subtitle: Text(DateFormat.yMMMd().format(transactions[index].date),
              ),

            trailing: IconButton(icon:Icon(Icons.delete),
                                color:Theme.of(context).errorColor,
                                onPressed: () => deleteTx(transactions[index].id),
            ),
            ),
          );

        },
        itemCount: transactions.length,
      ),
    );
  }
}
