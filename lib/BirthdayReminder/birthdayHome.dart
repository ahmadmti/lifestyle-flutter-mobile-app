import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
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

import '../home.dart';
import '../reminders.dart';
import 'birthday_details.dart';

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
        final GlobalBlocBirthday _globalBloc = Provider.of<GlobalBlocBirthday>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
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
      body:  Container(
        color: Color(0xFFF6F8FC),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 7,
              child: Provider<GlobalBlocBirthday>.value(
                child: BottomContainer(),
                value: _globalBloc,
              ),
            ),
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
class BottomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBlocBirthday _globalBloc = Provider.of<GlobalBlocBirthday>(context);
    return StreamBuilder<List<Birthday>>(
      stream: _globalBloc.birthdayList$,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.data.length == 0) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Text(
                "Add Reminder",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else {
          return Container(
            color: Colors.white,
            child: GridView.builder(
              padding: EdgeInsets.only(top: 12),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return MedicineCard(snapshot.data[index], _globalBloc);
              },
            ),
          );
        }
      },
    );
  }
}

class MedicineCard extends StatelessWidget {
  final Birthday birthday;
  final GlobalBlocBirthday globalBloc;

  MedicineCard(this.birthday, this.globalBloc);

 /* Hero makeIcon(double size) {
    if (medicine.medicineType == "Pill") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe901, fontFamily: "Ic"),
          color: Colors.blue,
          size: size,
        ),
      );
    } else if (medicine.medicineType == "Syringe") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe902, fontFamily: "Ic"),
          color: Colors.blue,
          size: size,
        ),
      );
    }
    return Hero(
      tag: medicine.medicineName + medicine.medicineType,
      child: Icon(
        Icons.error,
        color: Colors.blue,
        size: size,
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: InkWell(
        highlightColor: Colors.white,
        splashColor: Colors.grey,
                onLongPress: () => _showAlertDialog(context, birthday, globalBloc),

        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder<Null>(
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return AnimatedBuilder(
                    animation: animation,
                    builder: (BuildContext context, Widget child) {
                      return Opacity(
                        opacity: animation.value,
                        child: BirthdayDetails(birthday),
                      );
                    });
              },
              transitionDuration: Duration(milliseconds: 200),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
               // makeIcon(50.0),
                Hero(
                  tag: birthday.birthdayName,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      birthday.birthdayName,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Text(
                  birthday.interval == 0
                      ?   "On time":
                  birthday.interval == 1
                      ?  birthday.interval.toString() + " hour before"
                      : birthday.interval.toString() + " hours before",
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFC9C9C9),
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showAlertDialog(BuildContext context,Birthday birthday, GlobalBlocBirthday globalBloc) => showDialog(
        useRootNavigator: false,
        context: context,
        builder: (_) => AlertDialog(
          title: Text("${birthday.birthdayName??''}"),
          actions: [
            FlatButton(
                onPressed: () {
                  globalBloc.removeBirthday(birthday).then((value) {
                    Navigator.of(context).pop();
                    
                  });
                },
                child: Text("Delete", style: TextStyle(color: Colors.redAccent))),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Edit")),
          ],
        ),
      );
}


