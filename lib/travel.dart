import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/settings.dart';
import 'package:lifestyle/userAccount.dart';

import 'Travel/widget/home_screen.dart';
import 'home.dart';
import 'main.dart';
import 'mainHome.dart';

// ignore: camel_case_types
class travel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return travelState();
  }
}

class travelState extends State<travel> {
    Widget _child;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyFlightInfoField())))
          ],
          title: Text("Travel"),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white54,
            child: Center(
              child: Column(
                children: [
                  Card(
                    child: InkWell(
                      onTap: () {
                        url_launcher("https://www.emirates.com/ae/english/");
                      },
                      child: Image.asset("assets/travel_image/emirates.jpeg", height: 200.0, width: 350.0),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: () {
                        url_launcher("https://www.britishairways.com/travel/home/public/en_ae/");
                      },
                      child: Image.asset(
                        "assets/travel_image/bristish.jpeg",
                        height: 200.0,
                        width: 350.0,
                      ),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: () {
                        // Perform some action
                        url_launcher("http://www.airindia.in/");
                      },
                      child: Image.asset(
                        "assets/travel_image/airindia.jpeg",
                        height: 200.0,
                        width: 350.0,
                      ),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: () {
                        // Perform some action
                        url_launcher("https://www.etihad.com/en-ae/");
                      },
                      child: Image.asset(
                        "assets/travel_image/eithad.jpeg",
                        height: 200.0,
                        width: 350.0,
                      ),
                    ),
                  ),

                  //CHANGE FROM HERE
                  Card(
                    child: InkWell(
                      onTap: () {
                        url_launcher("https://www.kuwaitairways.com/en");
                      },
                      child: Image.asset("assets/travel_image/kuwait.jpeg", height: 200.0, width: 350.0),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: () {
                        url_launcher("https://www.singaporeair.com/en_UK/ae/home#/book/bookflight");
                      },
                      child: Image.asset(
                        "assets/travel_image/singapore.jpeg",
                        height: 200.0,
                        width: 350.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
