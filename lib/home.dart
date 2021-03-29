import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/reminders.dart';
import 'package:lifestyle/shopping.dart';
import 'package:lifestyle/todoList.dart';
import 'package:lifestyle/travel.dart';

import 'emergency/emergency.dart';
import 'financeHome.dart';
import 'medicalHome.dart';
import 'motivation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: GridView.count(crossAxisCount: 2, children: <Widget>[
        Card(
          margin: EdgeInsets.all(20.0),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => financeHome()));
            },
            splashColor: Colors.blue,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.attach_money_rounded, size: 50.0, color: Colors.blue),
                  Text("Finance", style: new TextStyle(fontSize: 18.0, color: Colors.blue))
                ],
              ),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(20.0),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => medicalHome()));
            },
            splashColor: Colors.green,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.medical_services_outlined, size: 50.0, color: Colors.green),
                  Text("Health", style: new TextStyle(fontSize: 18.0, color: Colors.green))
                ],
              ),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(20.0),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => reminders()));
            },
            splashColor: Colors.red,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.alarm_add_outlined, size: 50.0, color: Colors.red),
                  Text("Reminder", style: new TextStyle(fontSize: 18.0, color: Colors.red))
                ],
              ),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(20.0),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => todoList()));
            },
            splashColor: Colors.orange,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.today_outlined, size: 50.0, color: Colors.orange),
                  Text("To-Do List", style: new TextStyle(fontSize: 18.0, color: Colors.orange))
                ],
              ),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(20.0),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => travel()));
            },
            splashColor: Colors.black,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.airplanemode_on_outlined, size: 50.0, color: Colors.black),
                  Text("Travel", style: new TextStyle(fontSize: 18.0, color: Colors.black))
                ],
              ),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(20.0),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => shopping()));
            },
            splashColor: Colors.blueGrey,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.shopping_bag_outlined, size: 50.0, color: Colors.blueGrey),
                  Text("shopping", style: new TextStyle(fontSize: 18.0, color: Colors.blueGrey))
                ],
              ),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(20.0),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => emergency()));
            },
            splashColor: Colors.redAccent,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.local_police_outlined,
                    size: 50.0,
                    color: Colors.redAccent,
                  ),
                  Text("Emergency",
                      style: new TextStyle(
                        fontSize: 18.0,
                        color: Colors.redAccent,
                      ))
                ],
              ),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(20.0),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => motivation()));
            },
            splashColor: Colors.tealAccent[700],
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.format_quote_outlined,
                    size: 50.0,
                    color: Colors.tealAccent[700],
                  ),
                  Text("Motivational",
                      style: new TextStyle(
                        fontSize: 18.0,
                        color: Colors.tealAccent[700],
                      ))
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
