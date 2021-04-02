import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/FitnessPlan/tabs/tabs.dart';
import 'package:lifestyle/userAccount.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/settings.dart';
import 'package:lifestyle/Health/DietPlan/dietPlan.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'FitnessPlan/calculator/screens/homePage.dart';
import 'home.dart';
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
  double bmi = 0.0;
  @override
  void initState() {
    super.initState();
    getData();

    getBMI();
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
                    color: Colors.greenAccent[400],
                    height: 300,
                    child: AppBar(
                      backgroundColor: Colors.greenAccent[400],
                      title: Text(
                        'Health',
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Scaffold(
                  body: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .15),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 50,
                          child: Card(
                            color: Colors.greenAccent[400],
                            margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: InkWell(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())).then((value) => getBMI()),
                              splashColor: Colors.white,
                              child: Center(
                                child: Text("Calculate BMI",
                                    style: new TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                height: 120,
                                child: Card(
                                  margin: EdgeInsets.fromLTRB(40, 0, 20, 0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => dietPlan(bmi)));
                                    },
                                    splashColor: Colors.white,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(Icons.fastfood_outlined, size: 50.0, color: Colors.green),
                                            Text("Diet Plans",
                                                style: new TextStyle(fontSize: 16.0, color: Colors.green))
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
                                  margin: EdgeInsets.fromLTRB(20, 0, 40, 0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Tabs()));
                                    },
                                    splashColor: Colors.white,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(Icons.fitness_center, size: 50.0, color: Colors.blue),
                                            Text("Fitness Plan",
                                                style: new TextStyle(fontSize: 16.0, color: Colors.blue))
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
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     Expanded(
                        //       child: Container(
                        //         height: 120,
                        //         child: Card(
                        //           margin: EdgeInsets.fromLTRB(120, 0, 120, 0),
                        //           child: InkWell(
                        //             onTap: () {},
                        //             splashColor: Colors.white,
                        //             child: Center(
                        //               child: Padding(
                        //                 padding: const EdgeInsets.all(8.0),
                        //                 child: Column(
                        //                   mainAxisSize: MainAxisSize.min,
                        //                   children: <Widget>[
                        //                     Icon(Icons.fitness_center, size: 50.0, color: Colors.orange),
                        //                     Text("Exercises",
                        //                         style: new TextStyle(fontSize: 18.0, color: Colors.orange))
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                  bottomNavigationBar: FluidNavBar(
                    icons: [
                      FluidNavBarIcon(
                          icon: Icons.settings, backgroundColor: Colors.blue, extras: {"label": "settings"}),
                      FluidNavBarIcon(icon: Icons.home, backgroundColor: Colors.blue, extras: {"label": "home"}),
                      FluidNavBarIcon(
                          icon: Icons.supervised_user_circle_outlined,
                          backgroundColor: Colors.blue,
                          extras: {"label": "account"})
                    ],
                    onChange: _handleNavigationChange,
                    style: FluidNavBarStyle(
                        iconUnselectedForegroundColor: Colors.white, barBackgroundColor: Colors.grey[200]),
                    scaleFactor: 1.5,
                    defaultIndex: 1,
                    itemBuilder: (icon, item) => Semantics(
                      label: icon.extras["label"],
                      child: item,
                    ),
                  ),
                ))
              ],
            ),
            Positioned(
                right: 0,
                left: 0,
                top: MediaQuery.of(context).size.height * .16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Your BMI Index",
                        style: new TextStyle(
                          fontSize: 12.0,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text("$bmi",
                        style: new TextStyle(
                          fontSize: 34.0,
                          color: Colors.white,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        (bmi > 0 && bmi < 18.5)
                            ? "You are underweight"
                            : (bmi >= 18.5 && bmi < 25)
                                ? "You are healthy!"
                                : (bmi >= 25 && bmi <= 30)
                                    ? "You are overweight"
                                    : (bmi > 30)
                                        ? "You are obese"
                                        : "",
                        style: new TextStyle(
                          fontSize: 28.0,
                          color: Colors.white,
                        )),
                  ],
                )),
            Positioned(
                right: 0,
                left: 0,
                top: MediaQuery.of(context).size.height * .35,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            height: 70,
                            child: Card(
                              margin: EdgeInsets.fromLTRB(40, 20, 10, 0),
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
                                        child: Text("Underweight",
                                            style: new TextStyle(
                                              fontSize: 8.0,
                                            )),
                                      ),
                                    ),
                                    Center(
                                      child: Text("<18.5",
                                          style: new TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.yellow[800],
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
                            height: 70,
                            child: Card(
                              elevation: 6,
                              margin: EdgeInsets.fromLTRB(10, 20, 40, 0),
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
                                        child: Text("Normal",
                                            style: new TextStyle(
                                              fontSize: 8.0,
                                            )),
                                      ),
                                    ),
                                    Center(
                                      child: Text("18.5 - 25",
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
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            height: 70,
                            child: Card(
                              margin: EdgeInsets.fromLTRB(40, 20, 10, 0),
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
                                        child: Text("Overweight",
                                            style: new TextStyle(
                                              fontSize: 8.0,
                                            )),
                                      ),
                                    ),
                                    Center(
                                      child: Text("25 - 30",
                                          style: new TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.red,
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
                            height: 70,
                            child: Card(
                              elevation: 6,
                              margin: EdgeInsets.fromLTRB(10, 20, 40, 0),
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
                                        child: Text("Obese",
                                            style: new TextStyle(
                                              fontSize: 8.0,
                                            )),
                                      ),
                                    ),
                                    Center(
                                      child: Text("> 30",
                                          style: new TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.red[900],
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
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

  void getBMI() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        bmi = value.getDouble("BMI") ?? 0.0;
      });
    });
  }
}
