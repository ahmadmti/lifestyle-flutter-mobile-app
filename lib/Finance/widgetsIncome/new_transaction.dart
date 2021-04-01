import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgetsExpense//adaptive_flat_button.dart';

 var categories = <String>[
    'Entertainment',
    'Food',
    'Grocery',
    'Health',
  ];

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  // DateTime _selectedDate;
  String _selectedCat ;
  String holder;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final title = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (title.isEmpty || enteredAmount <= 0 || _selectedCat==null) {
      return;
    }

    widget.addTx(
      title,
      enteredAmount,
      // _selectedDate,
      _selectedCat
    );

    Navigator.of(context).pop();
  }

  // void _presentDatePicker() {
  //   showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1998),
  //     lastDate: DateTime.now(),
  //   ).then((pickedDate) {
  //     if (pickedDate == null) {
  //       return;
  //     }
  //     setState(() {
  //       _selectedDate = pickedDate;
  //     });
  //   });
  //   print('...');
  // }

 

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,

                onSubmitted: (_) => _submitData(),
                // onChanged: (val) => amountInput = val,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) => amountInput = val,
              ),
              // Container(
              //   height: 70,
              //   child: Row(
              //     children: <Widget>[
              //       Expanded(
              //         child: Text(
              //           _selectedDate == null
              //               ? 'No Date Chosen!'
              //               : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
              //         ),
              //       ),
              //       AdaptiveFlatButton('Choose Date', _presentDatePicker)
              //     ],
              //   ),
              // ),
           SizedBox(height: 10,), 
               Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Choose Category',
                      ),
                    ),
                    DropdownButton<String>(
                      iconEnabledColor: Colors.blue,
                      hint: Text(
                              "Select one",
                              style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
                            ),
                      elevation: 4,
                      value:  _selectedCat,
                      items: categories.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            "$value",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          _selectedCat = newVal;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,), 
                           RaisedButton(
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
