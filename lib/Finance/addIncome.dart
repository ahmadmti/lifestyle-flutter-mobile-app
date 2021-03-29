import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:lifestyle/Finance/widgetsIncome/new_transaction.dart';
import 'package:lifestyle/Finance/widgetsIncome/transaction_list.dart';
import 'package:lifestyle/Finance/widgetsIncome/chart.dart';

import '../Finance/models/transaction.dart';

class addIncome extends StatefulWidget {
  @override
  addIncomeState createState() => addIncomeState();
}

class addIncomeState extends State<addIncome> {
  final List<mTransaction> _userTransactions = [];
  bool _showChart = false;
  final FirebaseFirestore db = FirebaseFirestore.instance;
    var firebaseUser = FirebaseAuth.instance.currentUser;

  List<mTransaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    //insert into DB
    String transId = DateTime.now().millisecondsSinceEpoch.toString();
    db.collection("transactions").doc(firebaseUser.uid).collection("income").doc(transId).set({
      "id": transId,
      "title": txTitle,
      "amount": txAmount,
      "date": chosenDate,
    }).then((_) {
      Fluttertoast.showToast(
          msg: "Transaction Added Successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      final newTx = mTransaction(
        title: txTitle,
        amount: txAmount,
        date: chosenDate,
        id: DateTime.now().toString(),
      );

      setState(() {
        _userTransactions.add(newTx);
      });
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    db.collection("transactions").doc(firebaseUser.uid).collection("income").doc(id).delete().then((value) {
      setState(() {
        _userTransactions.removeWhere((tx) => tx.id == id);
      });
      Fluttertoast.showToast(
          msg: "Transaction Deleted Successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  @override
  void initState() {
    fetchIncome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            backgroundColor: Colors.blue,
            middle: Text('Add Income', style: TextStyle(color: Colors.white)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add, color: Colors.white),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            backgroundColor: Colors.blue,
            title: Text(
              'Add Income',
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );
    final txListWidget = Container(
      height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.title,
                  ),
                  Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
            if (!isLandscape)
              Container(
                height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,
                child: Chart(_recentTransactions),
              ),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
                      child: Chart(_recentTransactions),
                    )
                  : txListWidget
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }

  fetchIncome() {
    db.collection("transactions").doc(firebaseUser.uid).collection("income").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        var date = DateTime.parse(element['date'].toDate().toString());

        _userTransactions
            .add(mTransaction(id: element['id'], title: element['title'], amount: element['amount'], date: date));
        print("doc: ${element['amount']}");
      });
    }).then((value) => setState(() {}));
  }
}
