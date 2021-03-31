import 'dart:io';

import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/settings.dart';
import 'package:lifestyle/userAccount.dart';

import '../home.dart';

class EmergencyHospitals extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EmergencyHospitalsState();
  }
}

class EmergencyHospitalsState extends State<EmergencyHospitals> {
  Widget _child;
  final double blur = 30;
  final double offset = 20;
  final double top = 100;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Platform.isIOS ? Icons.arrow_back_ios_rounded : Icons.arrow_back_rounded,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text("Emergency Hospitals"),
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 120, 20, 20),
          child: Container(
              child: ListView(
            children: <Widget>[
              Card(
                child: ListTile(
                  title: Text(
                    'Al Kuwait Hospital',
                  ),
                  subtitle: Text("042710000"),
                  trailing: Icon(Icons.call),
                  onTap: () {
                    _callNumberH("042710000");
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    'Zulekha hospital',
                  ),
                  subtitle: Text("600524442"),
                  trailing: Icon(Icons.call),
                  onTap: () {
                    _callNumberH("600524442");
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    'Dubai Hospital',
                  ),
                  subtitle: Text("042195000"),
                  trailing: Icon(Icons.call),
                  onTap: () {
                    _callNumberH("042195000");
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    'Rashid Hospital',
                  ),
                  subtitle: Text("042192000"),
                  trailing: Icon(Icons.call),
                  onTap: () {
                    _callNumberH("042192000");
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    'Thumbay Hospital',
                  ),
                  subtitle: Text("042985555"),
                  trailing: Icon(Icons.call),
                  onTap: () {
                    _callNumberH("042985555");
                  },
                ),
              ),
            ],
          )),
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
    ));
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

  _callNumberH(number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}
