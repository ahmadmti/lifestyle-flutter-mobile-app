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
    );
  }
}
