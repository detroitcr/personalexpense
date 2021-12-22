import 'package:flutter/material.dart';
import 'package:personalexpense/widgets/new_transaction.dart';
import 'package:personalexpense/widgets/transaction_list.dart';
//import 'package:personalexpense/widgets/user_transaction.dart';
import 'models/transaction.dart';
import 'widgets/chart.dart';
void main() {
  runApp(PersonalExpenseApp());
}

class PersonalExpenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      // theme widget allow to setup a globalapplication wide theme
      theme:ThemeData(
        primarySwatch: Colors.purple,
        //ColorScheme.secondary is used in latest flutter but we use accent color in this project
        accentColor: Colors.amber,
        errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
          subtitle2: TextStyle(
            fontFamily: 'Opensans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          button: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            subtitle1:TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        fontFamily: 'Quicksand',
      ),
      home: _MyHomePage(),
    );
  }
}
// stateful class
class _MyHomePage extends StatefulWidget {
  @override
  State<_MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(amount: 500, date: DateTime.now(), id: 'Cr', title: 'Vikas'),
    // Transaction(amount: 700, date: DateTime.now(), id: 'vk', title: 'Romeo'),
  ];
  
  List<Transaction> get _recentTransactions{
    
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
        );
    }).toList();
  }


  void _addNewTransaction(String txtitle, double txamount,DateTime chosenDate) {
    final newTx = Transaction(
        amount: txamount,
        date: chosenDate,
        id: DateTime.now().toString(),
        title: txtitle);
    // update the transaction list so we use set state
    setState(() {
      _userTransactions.add(newTx);
     // print('adding new transaction');
    });
  }
  // function so we pressed start the process showing input area
  void _startAddNewTransactions(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return GestureDetector(
        onTap: (){},
        child: NewTransaction(_addNewTransaction),
        behavior: HitTestBehavior.opaque,
          );
            },
        );
      }

   void  _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id ==id);
    });
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        // for type a transaction but this time we have to use iconbutton
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed:() => _startAddNewTransactions(context),
          //  color: Colors.lightBlueAccent,
          ),
        ],
      ),
      // For whole list scrollable // method 1
      body: SingleChildScrollView(
        //method 2 ListView
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            // Container(
            //   width: double.infinity,
            //   child: Card(
            //     child: Center(
            //       child: Text('Chart'),
            //     ),
            //     color: Colors.blue,
            //     shadowColor: Colors.tealAccent,
            //     elevation: 20,
            //   ),
            // ),
            TransactionList(_userTransactions,_deleteTransaction),
          ],
        ),
      ),
      // for taking position in centered floating action button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
        onPressed: () => _startAddNewTransactions(context),
      ),
    );
  }
}
