import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:lifestyle/emergency/emergency_hospitals.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/settings.dart';
import 'package:lifestyle/userAccount.dart';

class emergency extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return emergencyState();
  }
}

class emergencyState extends State<emergency> {
  Widget _child;
  final double blur = 30;
  final double offset = 20;
  final double top = 100;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("Emergency"),
              ),
            ),
            drawer: Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  new UserAccountsDrawerHeader(
                    accountName: new Text('Murtaza'),
                    accountEmail: new Text('murtaza.sharbat786@gmail.com'),
                    currentAccountPicture: new CircleAvatar(
                      backgroundImage: new NetworkImage('url'),
                    ),
                  ),
                  ListTile(
                    title: Text('About Page'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Terms & Conditions'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            body: AnimatedContainer(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeOutQuint,
    margin: EdgeInsets.only(top: 50, bottom: 50, right: 30,left: 10),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    image: DecorationImage(
    fit: BoxFit.cover,
    image: NetworkImage('https://i.stack.imgur.com/JHYTI.jpg'),
    ),

    boxShadow: [BoxShadow(color: Colors.black87, blurRadius: blur, offset: Offset(offset, offset))]
    ),
    child:Padding(
      padding: const EdgeInsets.fromLTRB(20,150,20,20),
      child: Container(
                  child: ListView(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.directions_boat,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'Ambulance - 998',
                      ),
                      onTap: () {
                        _callNumberA();
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.local_police,
                        color: Colors.red,
                      ),
                      title: Text(
                        'Police - 999',
                      ),
                      onTap: () {
                        _callNumberP();
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.directions_car_outlined,
                        color: Colors.deepOrange,
                      ),
                      title: Text(
                        'Fire - 997',
                      ),
                      onTap: () {
                        _callNumberF();
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.local_hospital,
                        color: Colors.green,
                      ),
                      title: Text(
                        'Hospitals',
                      ),
                      onTap: () {
                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EmergencyHospitals()));
                      },
                    ),
                  ),
                ],
              )),
    ),),
            bottomNavigationBar: BottomAppBar(
                shape: CircularNotchedRectangle(),
                child: Container(
                  height: 70,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        iconSize: 50.0,
                        icon: Icon(Icons.settings),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => settings()));
                        },
                      ),
                      IconButton(
                        iconSize: 50.0,
                        icon: Icon(Icons.home),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => mainHome()));
                        },
                      ),
                      IconButton(
                        iconSize: 50.0,
                        icon: Icon(Icons.supervised_user_circle_outlined),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => userAccount()));
                        },
                      )
                    ],
                  ),
                ))));
  }
  _callNumberA() async{
    const number = '998'; //set the number here
    bool res = await FlutterPhoneDirectCaller.callNumber(number);}
  _callNumberP() async{
    const number = '999'; //set the number here
    bool res = await FlutterPhoneDirectCaller.callNumber(number);}
  _callNumberF() async{
    const number = '997'; //set the number here
    bool res = await FlutterPhoneDirectCaller.callNumber(number);}
  _callNumberH() async{
    const number = '111'; //set the number here
    bool res = await FlutterPhoneDirectCaller.callNumber(number);}
}
