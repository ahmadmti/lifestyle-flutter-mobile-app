import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/BirthdayReminder/birthday_reminder_bloc.dart';
import 'package:lifestyle/BirthdayReminder/new_entry_birthday.dart';
import 'package:lifestyle/Reminder/MedicalReminder/models/birthday.dart';
import 'package:lifestyle/login/Login.dart';
import 'package:lifestyle/main.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/settings.dart';
import 'package:lifestyle/userAccount.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class BadHabitHome extends StatefulWidget {
  @override
  _BadHabitHomeState createState() => _BadHabitHomeState();
}

class _BadHabitHomeState extends State<BadHabitHome> {
  bool _switchValueSmoking = false;
  bool _switchValueSleeping = false;
  bool _switchValueWalking = false;
  bool _switchValueAlcohol = false;
  bool _switchValueExercising = false;
  bool _switchValueCoffee = false;
  bool _switchValueFood = false;
  Widget _child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text("Bad Habit Reminder"),
        ),
      ),
      body: Container(
        color: Color(0xFFF6F8FC),
        child: ListView(
          children: [
            Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Smoking",
                    ),
                    Platform.isAndroid
                        ? Switch(
                            value: _switchValueSmoking,
                            onChanged: (value) {
                              setState(() {
                                _switchValueSmoking = value;
                              });
                            },
                          )
                        : CupertinoSwitch(
                            value: _switchValueSmoking,
                            onChanged: (value) {
                              setState(() {
                                _switchValueSmoking = value;
                                // pref.setUserType(value ? Utils.user_type_seller : Utils.user_type_buyer);
                                // Timer(Duration(seconds: 1), () => Utils.pushAndRemoveUntil(HomePage(), context));
                              });
                            },
                          ),
                  ],
                )),
            Divider(),
            Padding(
                                padding: EdgeInsets.all(5),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sleeping on time",
                    ),
                    Platform.isAndroid
                        ? Switch(
                            value: _switchValueSleeping,
                            onChanged: (value) {
                              setState(() {
                                _switchValueSleeping = value;
                              });
                            },
                          )
                        : CupertinoSwitch(
                            value: _switchValueSleeping,
                            onChanged: (value) {
                              setState(() {
                                _switchValueSleeping = value;
                                // pref.setUserType(value ? Utils.user_type_seller : Utils.user_type_buyer);
                                // Timer(Duration(seconds: 1), () => Utils.pushAndRemoveUntil(HomePage(), context));
                              });
                            },
                          ),
                  ],
                )),
            Divider(),
            Padding(
                              padding: EdgeInsets.all(5),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Walking",
                    ),
                    Platform.isAndroid
                        ? Switch(
                            value: _switchValueWalking,
                            onChanged: (value) {
                              setState(() {
                                _switchValueWalking = value;
                              });
                            },
                          )
                        : CupertinoSwitch(
                            value: _switchValueWalking,
                            onChanged: (value) {
                              setState(() {
                                _switchValueWalking = value;
                                // pref.setUserType(value ? Utils.user_type_seller : Utils.user_type_buyer);
                                // Timer(Duration(seconds: 1), () => Utils.pushAndRemoveUntil(HomePage(), context));
                              });
                            },
                          ),
                  ],
                )),
            Divider(),
            Padding(
                              padding: EdgeInsets.all(5),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Alcohol",
                    ),
                    Platform.isAndroid
                        ? Switch(
                            value: _switchValueAlcohol,
                            onChanged: (value) {
                              setState(() {
                                _switchValueAlcohol = value;
                              });
                            },
                          )
                        : CupertinoSwitch(
                            value: _switchValueAlcohol,
                            onChanged: (value) {
                              setState(() {
                                _switchValueAlcohol = value;
                                // pref.setUserType(value ? Utils.user_type_seller : Utils.user_type_buyer);
                                // Timer(Duration(seconds: 1), () => Utils.pushAndRemoveUntil(HomePage(), context));
                              });
                            },
                          ),
                  ],
                )),
            Divider(),
            Padding(
                              padding: EdgeInsets.all(5),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Exercising",
                    ),
                    Platform.isAndroid
                        ? Switch(
                            value: _switchValueExercising,
                            onChanged: (value) {
                              setState(() {
                                _switchValueExercising = value;
                              });
                            },
                          )
                        : CupertinoSwitch(
                            value: _switchValueExercising,
                            onChanged: (value) {
                              setState(() {
                                _switchValueExercising = value;
                                // pref.setUserType(value ? Utils.user_type_seller : Utils.user_type_buyer);
                                // Timer(Duration(seconds: 1), () => Utils.pushAndRemoveUntil(HomePage(), context));
                              });
                            },
                          ),
                  ],
                )),
            Divider(),
            Padding(
                              padding: EdgeInsets.all(5),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Coffee",
                    ),
                    Platform.isAndroid
                        ? Switch(
                            value: _switchValueCoffee,
                            onChanged: (value) {
                              setState(() {
                                _switchValueCoffee = value;
                              });
                            },
                          )
                        : CupertinoSwitch(
                            value: _switchValueCoffee,
                            onChanged: (value) {
                              setState(() {
                                _switchValueCoffee = value;
                                // pref.setUserType(value ? Utils.user_type_seller : Utils.user_type_buyer);
                                // Timer(Duration(seconds: 1), () => Utils.pushAndRemoveUntil(HomePage(), context));
                              });
                            },
                          ),
                  ],
                )),
            Divider(),
            Padding(
                              padding: EdgeInsets.all(5),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Fast Food",
                    ),
                    Platform.isAndroid
                        ? Switch(
                            value: _switchValueFood,
                            onChanged: (value) {
                              setState(() {
                                _switchValueFood = value;
                              });
                            },
                          )
                        : CupertinoSwitch(
                            value: _switchValueFood,
                            onChanged: (value) {
                              setState(() {
                                _switchValueFood = value;
                                // pref.setUserType(value ? Utils.user_type_seller : Utils.user_type_buyer);
                                // Timer(Duration(seconds: 1), () => Utils.pushAndRemoveUntil(HomePage(), context));
                              });
                            },
                          ),
                  ],
                )),
            Divider(),
          ],
        ),
      ),

      bottomNavigationBar: FluidNavBar(
          icons: [
            FluidNavBarIcon(icon: Icons.settings, backgroundColor: Colors.blue, extras: {"label": "settings"}),
            FluidNavBarIcon(icon: Icons.home, backgroundColor: Colors.blue, extras: {"label": "home"}),
            FluidNavBarIcon(
                icon: Icons.supervised_user_circle_outlined, backgroundColor: Colors.blue, extras: {"label": "account"})
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

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
        _child = settings();
        Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => mainHome(index : 0)), (Route<dynamic> route) => false);
          break;

        case 1:
         _child = Home();
          Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => mainHome(index : 1)), (Route<dynamic> route) => false);
          break;

        case 2:
       _child = userAccount();
Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => mainHome(index : 2)), (Route<dynamic> route) => false);
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
