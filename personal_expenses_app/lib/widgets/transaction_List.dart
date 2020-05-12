import 'package:flutter/material.dart';
import 'package:personal_expenses_app/model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transacton> transactions;
  final Function deleteTx;


  TransactionList( this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: transactions.isEmpty ? 
      Column(
        children: <Widget>[
        Text('No transaction added yet',
        style: TextStyle(
          fontSize: 18,
          fontWeight:FontWeight.bold,
        ),
        ),
        SizedBox(height:20),
        Container(
          height: 250,
          width: 300,
          child: Image.asset('assets/litepix.jpg',
          fit: BoxFit.cover,
          ),
        ),
      ],)
      : ListView.builder(
        itemBuilder: (ctx,  index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal:5,vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                radius:30,
               child: Padding(
                 padding:  EdgeInsets.all(6.0),
                 child: FittedBox(
                   child: Text('\$${transactions[index].amount.toStringAsFixed(2)}'),
                   ),
               ),
               ),
               title: Text(transactions[index].title,
               style: TextStyle(fontWeight: FontWeight.bold,
               ),
               ),
               subtitle: Text(
                 DateFormat.yMMMMd().format(transactions[index].date),
                 style: TextStyle(color:Colors.grey),
            ),
            trailing: MediaQuery.of(context).size.width >460
            ? FlatButton.icon(onPressed:  () => deleteTx(transactions[index].id), icon: Icon(Icons.delete), label: Text('Delete'),
             textColor: Theme.of(context).errorColor,
            ) 
            :IconButton(icon: Icon(Icons.delete), 
            onPressed: () => deleteTx(transactions[index].id),
            color: Theme.of(context).errorColor,
            ),
            ),
          );
        },
        itemCount: transactions.length,
        ),
    );
  }
}