import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:lifestyle/emergency/emergency_hospitals.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/settings.dart';
import 'package:lifestyle/userAccount.dart';

import '../home.dart';

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
              title: Text("Emergency"),
            ),
            // drawer: Drawer(
            //   child: ListView(
            //     // Important: Remove any padding from the ListView.
            //     padding: EdgeInsets.zero,
            //     children: <Widget>[
            //       new UserAccountsDrawerHeader(
            //         accountName: new Text('Murtaza'),
            //         accountEmail: new Text('murtaza.sharbat786@gmail.com'),
            //         currentAccountPicture: new CircleAvatar(
            //           backgroundImage: new NetworkImage('url'),
            //         ),
            //       ),
            //       ListTile(
            //         title: Text('About Page'),
            //         onTap: () {
            //           Navigator.pop(context);
            //         },
            //       ),
            //       ListTile(
            //         title: Text('Terms & Conditions'),
            //         onTap: () {
            //           Navigator.pop(context);
            //         },
            //       ),
            //     ],
            //   ),
            // ),
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
