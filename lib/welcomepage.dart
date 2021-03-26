import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/login/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class welcomePage extends StatefulWidget {
  @override
  welcomePageState createState() => welcomePageState();
}

class welcomePageState extends State<welcomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splash();
  }

  Future<void> splash()
  async {
    if(FirebaseAuth.instance.currentUser!=null)
    {if (FirebaseAuth.instance.currentUser.uid != null) {
      Timer(
          Duration(seconds: 5),
              () =>
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => mainHome()), 
              ));
    }}
    else {
      Timer(
          Duration(seconds: 5),
              () =>
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => loginClass())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.blue),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.greenAccent,
                          size: 50.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        'Welcome to the \n OneStop Application',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
