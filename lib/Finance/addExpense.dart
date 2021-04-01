import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:lifestyle/Finance/widgetsExpense/new_transaction.dart';
import 'package:lifestyle/Finance/widgetsExpense/transaction_list.dart';
import 'package:lifestyle/Finance/widgetsExpense/chart.dart';

import '../Finance/models/transaction.dart';
import '../home.dart';
import '../mainHome.dart';
import '../settings.dart';
import '../userAccount.dart';

class addExpense extends StatefulWidget {
  @override
  addExpenseState createState() => addExpenseState();
}

class addExpenseState extends State<addExpense> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Widget _child;
  var totalBudget;
  final List<mTransaction> _userTransactions = [];
  bool _showChart = false;
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

  void _addNewTransaction(String txTitle, double txAmount, String selectedCat) {
    DateTime chosenDate = DateTime.now();
    totalBudget = 0.0; //set 0 before adding
    //insert into DB
    String transId = DateTime.now().millisecondsSinceEpoch.toString();
    db.collection("transactions").doc(firebaseUser.uid).collection("budget").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        if (selectedCat == element['category']) totalBudget += element['amount'];

        print("totalBudget: $totalBudget");
      });
    }).then((value) {
      db.collection("transactions").doc(firebaseUser.uid).collection("expenses").doc(transId).set({
        "id": transId,
        "title": txTitle,
        "amount": txAmount,
        "date": chosenDate,
        "category": selectedCat,
        "total_budget": totalBudget,
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
            category: selectedCat,
            totalBudget: totalBudget);

        setState(() {
          //locally
          _userTransactions.add(newTx);
        });
      });
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: new NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    db.collection("transactions").doc(firebaseUser.uid).collection("expenses").doc(id).delete().then((value) {
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
    super.initState();
    fetchExpenses();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            backgroundColor: Colors.blue,
            middle: Text(
              'Add Expense',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    CupertinoIcons.add,
                    color: Colors.white,
                  ),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Add Expense',
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
            bottomNavigationBar: FluidNavBar(
              icons: [
                FluidNavBarIcon(icon: Icons.settings, backgroundColor: Colors.blue, extras: {"label": "settings"}),
                FluidNavBarIcon(icon: Icons.home, backgroundColor: Colors.blue, extras: {"label": "home"}),
                FluidNavBarIcon(
                    icon: Icons.supervised_user_circle_outlined,
                    backgroundColor: Colors.blue,
                    extras: {"label": "account"})
              ],
              onChange: _handleNavigationChange,
              style:
                  FluidNavBarStyle(iconUnselectedForegroundColor: Colors.white, barBackgroundColor: Colors.grey[200]),
              scaleFactor: 1.5,
              defaultIndex: 1,
              itemBuilder: (icon, item) => Semantics(
                label: icon.extras["label"],
                child: item,
              ),
            ),
          );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = settings();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => mainHome(index: 0)), (Route<dynamic> route) => false);
          break;

        case 1:
          _child = Home();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => mainHome(index: 1)), (Route<dynamic> route) => false);
          break;

        case 2:
          _child = userAccount();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => mainHome(index: 2)), (Route<dynamic> route) => false);
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
  }

  fetchExpenses() {
    db.collection("transactions").doc(firebaseUser.uid).collection("expenses").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        var date = DateTime.parse(element['date'].toDate().toString());

        _userTransactions.add(mTransaction(
          id: element['id'],
          title: element['title'],
          amount: element['amount'],
          date: date,
          category: element['category'],
          totalBudget: double.parse(element['total_budget'].toStringAsFixed(0))
        ));
      });
    }).then((value) => setState(() {}));
  }
}
