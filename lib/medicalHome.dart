import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/FitnessPlan/tabs/tabs.dart';
import 'package:lifestyle/userAccount.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/settings.dart';
import 'package:lifestyle/Health/DietPlan/dietPlan.dart';

import 'login/Login.dart';
import 'main.dart';

class medicalHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return medicalHomeState();
  }
}

class medicalHomeState extends State<medicalHome> {
  Widget _child;
  final double blur = 30;
  final double offset = 20;
  final double top = 100;
  String name = '';
  String n = '';
  @override
  void initState() {
    super.initState();
    getData();
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Health"),
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
        child: Container(
          margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(30.0),
            child: Center(
              child: GridView.count(crossAxisCount: 2, children: <Widget>[
                Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => dietPlan()));
                    },
                    splashColor: Colors.white,
                    child: Center(
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(Icons.fastfood_outlined, size: 60.0, color: Colors.green),
                          Text("Diet Plans", style: new TextStyle(fontSize: 14.0, color: Colors.green))
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                    elevation: 5,
                  margin: EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Tabs()));
                    },
                    splashColor: Colors.white,
                    child: Center(
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(Icons.fitness_center, size: 60.0, color: Colors.blue),
                          Text("Fitness Plans", style: new TextStyle(fontSize: 14.0, color: Colors.blue))
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            )),
      ),
      // bottomNavigationBar: FluidNavBar(
      //   icons: [
      //     FluidNavBarIcon(icon: Icons.settings, backgroundColor: Colors.blue, extras: {"label": "settings"}),
      //     FluidNavBarIcon(icon: Icons.home, backgroundColor: Colors.blue, extras: {"label": "home"}),
      //     FluidNavBarIcon(
      //         icon: Icons.supervised_user_circle_outlined, backgroundColor: Colors.blue, extras: {"label": "account"}),
      //   ],
      //   onChange: _handleNavigationChange,
      //   style: FluidNavBarStyle(iconUnselectedForegroundColor: Colors.white, barBackgroundColor: Colors.grey[200]),
      //   scaleFactor: 1.5,
      //   defaultIndex: 1,
      //   itemBuilder: (icon, item) => Semantics(
      //     label: icon.extras["label"],
      //     child: item,
      //   ),
      // ),
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
