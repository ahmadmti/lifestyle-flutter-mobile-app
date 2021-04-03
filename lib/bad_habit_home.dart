import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lifestyle/BirthdayReminder/birthday_reminder_bloc.dart';
import 'package:lifestyle/BirthdayReminder/new_entry_birthday.dart';
import 'package:lifestyle/Reminder/MedicalReminder/models/birthday.dart';
import 'package:lifestyle/login/Login.dart';
import 'package:lifestyle/main.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/settings.dart';
import 'package:lifestyle/userAccount.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class BadHabitHome extends StatefulWidget {
  @override
  _BadHabitHomeState createState() => _BadHabitHomeState();
}

class _BadHabitHomeState extends State<BadHabitHome> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _switchValueSmoking = true;
  bool _switchValueSleeping = false;
  bool _switchValueWalking = false;
  bool _switchValueAlcohol = false;
  bool _switchValueExercising = false;
  bool _switchValueCoffee = false;
  bool _switchValueFood = false;
  Widget _child;

  @override
  void initState() {
    super.initState();

    _initLocalNoti();
    checkSwitchStates();
  }

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
                            onChanged: (value) async {
                              funcSmoking(value);
                            },
                          )
                        : CupertinoSwitch(
                            value: _switchValueSmoking,
                            onChanged: (value) async {
                              funcSmoking(value);
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
                            onChanged: (value) async {
                              funcSleeping(value);
                            },
                          )
                        : CupertinoSwitch(
                            value: _switchValueSleeping,
                            onChanged: (value) async {
                              funcSleeping(value);
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
                            onChanged: (value) async {
                              funcWalking(value);
                            },
                          )
                        : CupertinoSwitch(
                            value: _switchValueWalking,
                            onChanged: (value) async {
                              funcWalking(value);
                            }),
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
                            onChanged: (value) async {
                              funcAlcohol(value);
                            },
                          )
                        : CupertinoSwitch(
                            value: _switchValueAlcohol,
                            onChanged: (value) async {
                              funcAlcohol(value);
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
                            onChanged: (value) async {
                              funcExercising(value);
                            },
                          )
                        : CupertinoSwitch(
                            value: _switchValueExercising,
                            onChanged: (value) async {
                              funcExercising(value);
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
                            onChanged: (value) async {
                              funcCoffee(value);
                            },
                          )
                        : CupertinoSwitch(
                            value: _switchValueCoffee,
                            onChanged: (value) async {
                              funcCoffee(value);
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
                            onChanged: (value) async {
                              funcFood(value);
                            },
                          )
                        : CupertinoSwitch(
                            value: _switchValueFood,
                            onChanged: (value) async {
                              funcFood(value);
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

  void _initLocalNoti() {
    //initialize
    var initializationSettingsAndroid = new AndroidInitializationSettings('logo');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOs);
    flutterLocalNotificationsPlugin.initialize(initSetttings, onSelectNotification: selectNotification);
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => main()),
    // );
  }

  Future scheduledNotifyReminder(id, title, body) async {
    var android =
        AndroidNotificationDetails('$id', '$title', 'description', priority: Priority.high, importance: Importance.max);
    var iOS = IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      '$title',
      '$body',
      RepeatInterval.daily,
      platform,
      androidAllowWhileIdle: true,
    );
  }

  void checkSwitchStates() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _switchValueSmoking = pref.getBool("Smoking") ?? true;
    _switchValueSleeping = pref.getBool("Sleeping") ?? false;
    _switchValueWalking = pref.getBool("Walking") ?? false;
    _switchValueAlcohol = pref.getBool("Alcohol") ?? false;
    _switchValueExercising = pref.getBool("Exercising") ?? false;
    _switchValueCoffee = pref.getBool("Coffee") ?? false;
    _switchValueFood = pref.getBool("Food") ?? false;
    setState(() {});
  }

  void funcSmoking(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      _switchValueSmoking = value;
      if (value) {
        pref.setBool("Smoking", true);
        scheduledNotifyReminder(1, "Smoking", "Smocking is Injurious to Health");
      } else {
        pref.setBool("Smoking", false);
        flutterLocalNotificationsPlugin.cancel(1);
      }
    });
  }

  void funcSleeping(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      _switchValueSleeping = value;
      if (value) {
        pref.setBool("Sleeping", true);
        scheduledNotifyReminder(2, "Sleeping", "Oversleeping is Bad for Health");
      } else {
        pref.setBool("Sleeping", false);
        flutterLocalNotificationsPlugin.cancel(2);
      }
    });
  }

  void funcWalking(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      _switchValueWalking = value;
      if (value) {
        pref.setBool("Walking", true);
        scheduledNotifyReminder(3, "Walking", "Walking make body active");
      } else {
        pref.setBool("Walking", false);
        flutterLocalNotificationsPlugin.cancel(3);
      }
    });
  }

  void funcAlcohol(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      _switchValueAlcohol = value;
      if (value) {
        pref.setBool("Alcohol", true);
        scheduledNotifyReminder(4, "Alcohol", "Alcohol is Injurious to Health");
      } else {
        pref.setBool("Alcohol", false);
        flutterLocalNotificationsPlugin.cancel(4);
      }
    });
  }

  void funcExercising(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      _switchValueExercising = value;
      if (value) {
        pref.setBool("Exercising", true);
        scheduledNotifyReminder(5, "Exercising", "Exercising keeps man Fit.");
      } else {
        pref.setBool("Exercising", false);
        flutterLocalNotificationsPlugin.cancel(5);
      }
    });
  }

  void funcCoffee(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      _switchValueCoffee = value;
      if (value) {
        pref.setBool("Coffee", true);
        scheduledNotifyReminder(6, "Coffee", "Coffee burns the body fats");
      } else {
        pref.setBool("Coffee", false);
        flutterLocalNotificationsPlugin.cancel(6);
      }
    });
  }

  void funcFood(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      _switchValueFood = value;
      if (value) {
        pref.setBool("Food", true);
        scheduledNotifyReminder(7, "Food", "Always eat Healthy Food.");
      } else {
        pref.setBool("Food", false);
        flutterLocalNotificationsPlugin.cancel(7);
      }
    });
  }
}
