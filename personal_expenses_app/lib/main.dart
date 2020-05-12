import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses_app/model/transaction.dart';
import 'package:personal_expenses_app/widgets/chart.dart';
import 'package:personal_expenses_app/widgets/new_transaction.dart';
import 'package:personal_expenses_app/widgets/transaction_List.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
     debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget { 
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

   final List <Transacton> _userTransactions = [
      // Transacton(
      //   id: 't1',
      //    title: 'New Shoes',
      //     amount: 23.56,
      //      date: DateTime.now() 
      //      ),

];

List<Transacton> get _recentTransactions {
  return _userTransactions.where((tx){
    return tx.date.isAfter(
      DateTime.now().subtract(
        Duration(days: 7),
    ),);
  }).toList();
}

void _addNewTransaction(String title, double amount, DateTime chosenDate) {
  final newTx = 
  Transacton(
    title: title, 
    amount: amount,
     date: chosenDate,
  id:  DateTime.now().toString(),
  );

  setState(() {
    _userTransactions.add(newTx);
  });
}



  void _startAddNewTransaction(BuildContext  ctx){
    showModalBottomSheet(context: ctx, builder: (_) {
      return NewTransaction(_addNewTransaction);
    },
    ); 
  } 

  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id ==id;
      });
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: () => _startAddNewTransaction (context),
          ),
        ],
        title: Text('Pensonal Expenses'),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
          
            Chart(_recentTransactions),
           TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButton: Platform.isIOS 
      ? Container()
      :FloatingActionButton(
        onPressed: () => _startAddNewTransaction (context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
