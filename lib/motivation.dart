import 'dart:convert';

import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/userAccount.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/settings.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class motivation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return motivationState();
  }
}

class motivationState extends State<motivation> {
  var quote = "Fetching quote...", owner = '';
    Widget _child;

  @override
  void initState() {
    super.initState();

    getQuote();
  }

  getQuote() async {
    try {
      var response = await http.post(Uri.encodeFull('https://api.forismatic.com/api/1.0/'),
          body: {"method": "getQuote", "format": "json", "lang": "en"});
      setState(() {
        try {
          var res = jsonDecode(response.body);
          owner = res["quoteAuthor"];
          quote = res["quoteText"];

          print("quote: $quote");
        } catch (e) {
          getQuote();
        }
      });
    } catch (e) {
      quote = "Failed: Unable to fetch quote";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Motivation Page'),
        ),
        // drawer: Drawer(
        //   child: ListView(
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
        //         title: Text('User Settings'),
        //         onTap: () {
        //           Navigator.pop(context);
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "assets/images/quote.png",
              height: 150,
              width: 150,
              color: Colors.grey[300],
            ),
           
           Padding(padding: EdgeInsets.only(left: 10, right: 10),
           child:  Column(
              children: [
                Text(
                  quote,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "- $owner",
                  style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                )
              ],
            ),)
          ],
        )),
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

    // get a random Quote from the API
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
