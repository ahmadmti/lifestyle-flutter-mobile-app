import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/BirthdayReminder/new_entry_birthday.dart';
import 'package:lifestyle/login/Login.dart';
import 'package:lifestyle/main.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/settings.dart';
import 'package:lifestyle/userAccount.dart';

import '../reminders.dart';

class birthdayHome extends StatefulWidget {
  @override
  _birthdayHomeState createState() => _birthdayHomeState();
}

class _birthdayHomeState extends State<birthdayHome> {
  Widget _child;
  String name = '';
  String n = '';
  final FirebaseFirestore db = FirebaseFirestore.instance;
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
    //final ref =  await FirebaseStorage.instance
    //  .ref()
    //.child('Poster').getDownloadURL(); //get the data
    return name;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => reminders(),
                ),
              );
            },),
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text("Birthday Reminder"),
        ),

        actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.add,
                size: 35.0,
              ),
              tooltip: 'Add Reminder',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewEntryBirthday(),
                  ),
                );
              },
            ),
          ]
      ),
      body: Container(),
      bottomNavigationBar: FluidNavBar(
        icons: [
          FluidNavBarIcon(icon: Icons.settings, backgroundColor: Colors.blue, extras: {"label": "settings"}),
          FluidNavBarIcon(icon: Icons.home, backgroundColor: Colors.blue, extras: {"label": "home"}),
          FluidNavBarIcon(
              icon: Icons.supervised_user_circle_outlined, backgroundColor: Colors.blue, extras: {"label": "account"}),
        ],
        onChange: _handleNavigationChange,
        style: FluidNavBarStyle(iconUnselectedForegroundColor: Colors.white, barBackgroundColor: Colors.grey[200]),
        scaleFactor: 1.5,
        defaultIndex: 1,
        itemBuilder: (icon, item) => Semantics(
          label: icon.extras["label"],
          child: item,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = settings();
          Navigator.push(context, MaterialPageRoute(builder: (context) => settings()));
          break;
        case 1:
          _child = mainHome();
          Navigator.push(context, MaterialPageRoute(builder: (context) => mainHome()));
          break;
        case 2:
          _child = userAccount();
          Navigator.push(context, MaterialPageRoute(builder: (context) => userAccount()));
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

  void _onPressed() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    db.collection("user").doc(firebaseUser.uid).set({
      "name": "john",
      "age": 50,
      "date": "example@example.com",
    }).then((_) {
      print("success!");
    });
  }
}
