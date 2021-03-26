import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifestyle/login/Login.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/settings.dart';
import 'package:lifestyle/userAccount.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../main.dart';

DocumentSnapshot snapshot;

class shopHome extends StatefulWidget {
  @override
  _shopHomeState createState() => _shopHomeState();
}

class _shopHomeState extends State<shopHome> {
  Widget _child;
  String name = '';
  String n = '';
  final List<String> imageList = [
    "https://firebasestorage.googleapis.com/v0/b/onestop-bef04.appspot.com/o/Poster%2F945a3d5ff4ebd2e6c503d54df7075f7f.jpeg?alt=media&token=2ef5548e-739b-4324-bf05-daf7675a998c",
    "https://firebasestorage.googleapis.com/v0/b/onestop-bef04.appspot.com/o/Poster%2Fad57ffb78cf16a72816f0359ae992de8.jpeg?alt=media&token=6b811192-b262-40e5-9fcd-3011d6eb0585",
    "https://firebasestorage.googleapis.com/v0/b/onestop-bef04.appspot.com/o/Poster%2Fdisec3b1o-sin-tc3adtulo-3.jpg?alt=media&token=42698fd5-bb7d-45b9-b14a-1ee11fc8fd59",
    "https://firebasestorage.googleapis.com/v0/b/onestop-bef04.appspot.com/o/Poster%2FSeiko-watch-brand-960x640.jpg?alt=media&token=19b960fe-db0d-4d17-bfbe-650a768e7ab7",
  ];
  final List<String> imageCategory = [
    "https://firebasestorage.googleapis.com/v0/b/onestop-bef04.appspot.com/o/Poster%2F1_4bSCNYI9S4hU1zvWUhz8Ew.png?alt=media&token=dfb8ccb1-3bc2-4f82-8cdc-ae3b4dd0adf0",
    "https://firebasestorage.googleapis.com/v0/b/onestop-bef04.appspot.com/o/Poster%2F32659-global-kids-fashion-week-show.jpg?alt=media&token=fcbeec80-345e-44d6-850d-d5680a4d6bb9",
    "https://firebasestorage.googleapis.com/v0/b/onestop-bef04.appspot.com/o/Poster%2Fee24757862102b8ed98f0a707c15a75d.jpg?alt=media&token=0e1b3905-100c-430e-b16b-dfe37edab132",
  ];
  final List<String> imageCategory2 = [
    "https://firebasestorage.googleapis.com/v0/b/onestop-bef04.appspot.com/o/Poster%2Fimages.jpg?alt=media&token=1a88caa7-c7ba-4819-b714-ca4f1cf505d1",
    "https://firebasestorage.googleapis.com/v0/b/onestop-bef04.appspot.com/o/Poster%2Fmakeup-stock-getty.jpg?alt=media&token=75d7808f-009b-441a-b7d4-4bce3542e363",
    "https://firebasestorage.googleapis.com/v0/b/onestop-bef04.appspot.com/o/Poster%2F744454e8193040838daddd52e02a475a.png?alt=media&token=d0da1133-83e2-4797-a41a-6a23f8e728ce",
  ];

  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

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
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text("Shopping"),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(name),
              accountEmail: new Text(FirebaseAuth.instance.currentUser.email),
              currentAccountPicture: new CircleAvatar(
                backgroundImage:
                    new NetworkImage('https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png'),
              ),
            ),
            ListTile(
              title: Text('About Page'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Terms & Conditions'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Log Out'),
              onTap: () {
                Navigator.pop(context);
                FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => loginClass()),
                );
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          new Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Brand',
                              style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Shop',
                              style: new TextStyle(fontSize: 28.0, color: Colors.blue),
                            )
                          ],
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: GFCarousel(
                    autoPlay: true,
                    items: imageList.map(
                      (url) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(5, 20, 5, 20),
                          child: InkWell(
                            onTap: () {
                              if (url == imageList[0]) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                            appBar: AppBar(
                                              title: Text("OneStop"),
                                            ),
                                            body: WebView(
                                              initialUrl: 'https://www.nike.com',
                                            ))));
                              } else if (url == imageList[1]) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                            appBar: AppBar(
                                              title: Text("OneStop"),
                                            ),
                                            body: WebView(
                                              initialUrl: 'https://www.adidas.com/us',
                                            ))));
                              } else if (url == imageList[2]) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                            appBar: AppBar(
                                              title: Text("OneStop"),
                                            ),
                                            body: WebView(
                                              initialUrl: 'https://www.apple.com',
                                            ))));
                              } else if (url == imageList[3]) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                            appBar: AppBar(
                                              title: Text("OneStop"),
                                            ),
                                            body: WebView(
                                              initialUrl: 'https://www.monawatch.com/',
                                            ))));
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              child: Image.network(url, fit: BoxFit.fill, width: double.infinity),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                    onPageChanged: (index) {
                      setState(() {
                        index;
                      });
                    },
                  )),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 30, 15),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Categories',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(fontSize: 22, letterSpacing: 0, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: GFItemsCarousel(
                  itemHeight: 150,
                  rowCount: 3,
                  children: imageCategory.map(
                    (url) {
                      return Container(
                        margin: EdgeInsets.all(5.0),
                        child: InkWell(
                            onTap: () {
                              if (url == imageCategory[0]) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                            appBar: AppBar(
                                              title: Text("OneStop"),
                                            ),
                                            body: WebView(
                                              initialUrl: 'https://www.rhone.com/',
                                            ))));
                              } else if (url == imageCategory[1]) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                            appBar: AppBar(
                                              title: Text("OneStop"),
                                            ),
                                            body: WebView(
                                              initialUrl: 'https://www.melijoe.com/en',
                                            ))));
                              } else if (url == imageCategory[2]) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                            appBar: AppBar(
                                              title: Text("OneStop"),
                                            ),
                                            body: WebView(
                                              initialUrl: 'https://www.cuyana.com/',
                                            ))));
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              child: Image.network(url, fit: BoxFit.cover, width: 1000.0),
                            )),
                      );
                    },
                  ).toList(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: GFItemsCarousel(
                  itemHeight: 150,
                  rowCount: 3,
                  children: imageCategory2.map(
                    (url) {
                      return Container(
                        margin: EdgeInsets.all(5.0),
                        child: InkWell(
                            onTap: () {
                              if (url == imageCategory2[0]) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                            appBar: AppBar(
                                              title: Text("OneStop"),
                                            ),
                                            body: WebView(
                                              initialUrl: 'https://www.cuenawatchesco.com/',
                                            ))));
                              } else if (url == imageCategory2[1]) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                            appBar: AppBar(
                                              title: Text("OneStop"),
                                            ),
                                            body: WebView(
                                              initialUrl: 'https://www.esteelauder.com/',
                                            ))));
                              } else if (url == imageCategory2[2]) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                            appBar: AppBar(
                                              title: Text("OneStop"),
                                            ),
                                            body: WebView(
                                              initialUrl: 'https://www.zara.com/us/en/man-mkt534.html',
                                            ))));
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              child: Image.network(url, fit: BoxFit.cover, width: 1000.0),
                            )),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: FluidNavBar(
        icons: [
          FluidNavBarIcon(icon: Icons.settings, backgroundColor: Colors.blue, extras: {"label": "settings"}),
          FluidNavBarIcon(icon: Icons.home, backgroundColor: Colors.blue, extras: {"label": "home"}),
          FluidNavBarIcon(
              icon: Icons.supervised_user_circle_outlined, backgroundColor: Colors.blue, extras: {"label": "account"}),
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

  @override
  void dispose() {
    super.dispose();
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
