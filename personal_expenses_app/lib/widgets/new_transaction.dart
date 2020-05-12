import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class NewTransaction extends StatefulWidget {
 
  final Function  addTx;
  //String inputTitle;
 // String inputAmount;


  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse
  (_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 ||_selectedDate ==null) {

      return;
    }
   
    widget.addTx(
     
      enteredTitle,
      enteredAmount,
      _selectedDate,

   );

   Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(), 
      firstDate: DateTime(2019),
       lastDate: DateTime.now(), 
    ).then((pickedDate){
      if (pickedDate == null) {
        return;
      }
      setState(() {
         _selectedDate = pickedDate;
      });
     
    });
  
  }
  

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
          child: Card(
        elevation: 5,
              child: Container(
                padding: EdgeInsets.only(top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom +10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        hintText: 'Type your title here',
                      ),
                      // onChanged: (val) {
                      //   titleInput = val;
                      // },
                      onSubmitted: (_) => _submitData(),
                    ),
                    TextField(
                     controller: _amountController,
                      decoration: InputDecoration(
                          labelText: 'Amount', hintText: 'Type your amount here',
                          ),
                          keyboardType: TextInputType.number,
                          onSubmitted: (_) => _submitData (),
                      // onChanged: (val) {
                      //   amountInput = val;
                      // },
                    ),
                    Container(
                      height: 70,
                      child: Row(
                        children: <Widget>[
                        Expanded(
                          child: Text(
                            _selectedDate == null 
                            ? 'No Date Chosen!' 
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                          ),
                        ),
                        FlatButton(
                          onPressed: 
                            _presentDatePicker,
                          child: Text('Choose Date',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
                      ],),
                    ),
                    RaisedButton(
                      onPressed: _submitData,
                      child: Text('Add Transaction'),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}