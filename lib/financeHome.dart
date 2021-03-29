import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/main.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/Finance/addExpense.dart';
import 'package:lifestyle/Finance/addIncome.dart';
import 'package:lifestyle/Finance/setBudget.dart';
import 'package:lifestyle/medicalHome.dart';
import 'package:lifestyle/settings.dart';
import 'package:lifestyle/userAccount.dart';

import 'login/Login.dart';

class financeHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return financeHomePage();
  }
}

class financeHomePage extends State<financeHome> {
  bool active = true;
  Widget _child;
  final double blur = 30;
  final double offset = 20;
  final double top = 100;
  String name = '';
  String n = '';
  var totalBudget = 0.0;
  var totalIncome = 0.0;
  var totalExpense = 0.0;

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  void initState() {
    _child = mainHome();
    // getData();
    fetchStats();
    super.initState();
  }

  Future<String> getData() async {
    String n;
    await usersRef
        .reference()
        .child(FirebaseAuth.instance.currentUser.uid)
        .once()
        .then((DataSnapshot snapshot) => n = snapshot.value["name"]);

    setState(() {
      name = n;
    });

    return name;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    color: Colors.blue[300],
                    height: 300,
                    child: AppBar(
                      backgroundColor: Colors.blue[300],
                      title: Text(
                        'Finance',
                      ),
                      leading: IconButton(
                        icon: Icon(
                          Platform.isIOS ? Icons.arrow_back_ios_rounded : Icons.arrow_back_rounded,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Scaffold(
                  body: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .06),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                height: 120,
                                child: Card(
                                  color: Colors.red,
                                  margin: EdgeInsets.fromLTRB(40, 0, 20, 0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => addExpense())).then((value) => fetchStats());
                                    },
                                    splashColor: Colors.white,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(Icons.attach_money_outlined, size: 50.0, color: Colors.white),
                                            Text("Expense", style: new TextStyle(fontSize: 16.0, color: Colors.white))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 120,
                                child: Card(
                                  color: Colors.green,
                                  margin: EdgeInsets.fromLTRB(20, 0, 40, 0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => addIncome())).then((value) => fetchStats());
                                    },
                                    splashColor: Colors.white,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(Icons.attach_money_outlined, size: 50.0, color: Colors.white),
                                            Text("Income ", style: new TextStyle(fontSize: 16.0, color: Colors.white))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                height: 120,
                                child: Card(
                                  color: Colors.tealAccent[700],
                                  margin: EdgeInsets.fromLTRB(120, 0, 120, 0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => addBudget())).then((value) => fetchStats());
                                    },
                                    splashColor: Colors.white,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(Icons.alarm_add_outlined, size: 50.0, color: Colors.white),
                                            Text("Budget", style: new TextStyle(fontSize: 18.0, color: Colors.white))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ))
              ],
            ),
            Positioned(
                right: 0,
                left: 0,
                top: MediaQuery.of(context).size.height * .18,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Current Budget",
                        style: new TextStyle(
                          fontSize: 12.0,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text("AED $totalBudget",
                        style: new TextStyle(
                          fontSize: 34.0,
                          color: Colors.white,
                        )),
                  ],
                )),
            Positioned(
                right: 0,
                left: 0,
                top: MediaQuery.of(context).size.height * .34,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        child: Card(
                          margin: EdgeInsets.fromLTRB(40, 20, 10, 20),
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: InkWell(
                            onTap: null,
                            splashColor: Colors.white,
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Income",
                                        style: new TextStyle(
                                          fontSize: 8.0,
                                        )),
                                  ),
                                ),
                                Center(
                                  child: Text("AED $totalIncome",
                                      style: new TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.green,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        child: Card(
                          elevation: 6,
                          margin: EdgeInsets.fromLTRB(10, 20, 40, 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: InkWell(
                            onTap: null,
                            splashColor: Colors.white,
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Expense",
                                        style: new TextStyle(
                                          fontSize: 8.0,
                                        )),
                                  ),
                                ),
                                Center(
                                  child: Text("AED $totalExpense",
                                      style: new TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.redAccent,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  fetchStats() {
    db.collection("transactions").doc(firebaseUser.uid).collection("budget").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        totalBudget = totalBudget + double.parse(element['amount'].toString());
      });
    });

    db.collection("transactions").doc(firebaseUser.uid).collection("income").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        totalIncome = totalIncome + double.parse(element['amount'].toString());
      });
    });

    db.collection("transactions").doc(firebaseUser.uid).collection("expenses").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        totalExpense = totalExpense + double.parse(element['amount'].toString());
      });
    }).then((value) => setState(() {}));


  }
}
