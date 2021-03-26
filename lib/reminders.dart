import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import 'package:lifestyle/Reminder/MedicalReminder/MedicineMain.dart';
import 'package:lifestyle/settings.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/userAccount.dart';
import 'package:lifestyle/BirthdayReminder/birthdayHome.dart';
import 'WaterReminder/screens/data_entry_screen.dart';

class reminders extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return remindersState();
  }
}

class remindersState extends State<reminders> {
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
            child: Text("Reminders"),
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
                title: Text('User Settings'),
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
          margin: EdgeInsets.only(top: 50, bottom: 50, right: 30, left: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('https://i.stack.imgur.com/JHYTI.jpg'),
              ),
              boxShadow: [BoxShadow(color: Colors.black87, blurRadius: blur, offset: Offset(offset, offset))]),
          child: GridView.count(crossAxisCount: 2, children: <Widget>[
            Card(
              color: Colors.green,
              margin: EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MedicineMain()));
                },
                splashColor: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.medical_services_outlined, size: 50.0, color: Colors.white),
                      Text("Medicine", style: new TextStyle(fontSize: 15.0, color: Colors.white))
                    ],
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.lightBlue,
              margin: EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DataEntryScreen()));
                },
                splashColor: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.medical_services_outlined, size: 50.0, color: Colors.white),
                      Text("Water", style: new TextStyle(fontSize: 18.0, color: Colors.white))
                    ],
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.red,
              margin: EdgeInsets.all(15.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => birthdayHome()));
                },
                splashColor: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.alarm_add_outlined, size: 50.0, color: Colors.white),
                      Text("Birth-Day", style: new TextStyle(fontSize: 18.0, color: Colors.white))
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
        bottomNavigationBar: FluidNavBar(
          icons: [
            FluidNavBarIcon(icon: Icons.settings, backgroundColor: Colors.blue, extras: {"label": "settings"}),
            FluidNavBarIcon(icon: Icons.home, backgroundColor: Colors.blue, extras: {"label": "home"}),
            FluidNavBarIcon(
                icon: Icons.supervised_user_circle_outlined,
                backgroundColor: Colors.blue,
                extras: {"label": "account"}),
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
        /* BottomAppBar(
              shape: CircularNotchedRectangle(),
              child: Container(
                height: 75,
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
              ))*/
      ),
    );
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
}
