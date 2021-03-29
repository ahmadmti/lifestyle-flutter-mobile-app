import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/Motivation/MainPage.dart';
import 'package:lifestyle/Shoping/Home.dart';
import 'package:lifestyle/Travel/widget/home_screen.dart';
import 'package:lifestyle/financeHome.dart';
import 'package:lifestyle/home.dart';
import 'package:lifestyle/login/Login.dart';
import 'package:lifestyle/main.dart';
import 'package:lifestyle/medicalHome.dart';
import 'package:lifestyle/todo/ui/page_task.dart';
import 'package:lifestyle/todoList.dart';
import 'package:lifestyle/travel.dart';
import 'package:lifestyle/shopping.dart';
import 'package:lifestyle/settings.dart';
import 'package:lifestyle/reminders.dart';
import 'package:lifestyle/emergency/emergency.dart';
import 'package:lifestyle/motivation.dart';
import 'package:lifestyle/userAccount.dart';

import 'financeHome.dart';
import 'motivation.dart';

class mainHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return mainHomeState();
  }
}

class mainHomeState extends State<mainHome> {
  int a = 0;
  final PageController ctrl = PageController(viewportFraction: 0.8);
  Widget _child;

  String activeTag = 'Finance';

  // Keep track of current page to avoid unnecessary renders
  int currentPage = 0;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  // DatabaseReference _userData;
  // DatabaseReference usersRef=FirebaseDatabase.instance.reference().child("users");

  String name = '';
  String n = '';
  Stream slides;
  @override
  void initState() {
    _child = Home();
    super.initState();
    getData();
    _queryDb();
    ctrl.addListener(() {
      int next = ctrl.page.round();

      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
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
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text("OneStop"),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text(name ?? ''),
                accountEmail: new Text(FirebaseAuth.instance.currentUser.email ?? ''),
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
        // body:StreamBuilder(
        //     stream: slides,
        //     initialData: [],
        //     builder: (context, AsyncSnapshot snap) {

        //       List slideList = snap.data.toList();

        //       return PageView.builder(

        //           controller: ctrl,
        //           itemCount: slideList.length + 1,
        //           // ignore: missing_return
        //           itemBuilder: (context, int currentIdx) {

        //             if (currentIdx == 0) {
        //               return _buildTagPage();
        //             } else if (slideList.length >= currentIdx) {
        //               // Active page
        //               bool active = currentIdx == currentPage;
        //               return _buildStoryPage(slideList[currentIdx - 1], active);
        //             }
        //           }
        //       );
        //     }
        // ),
        body: _child,
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
        /* BottomAppBar(
              shape: CircularNotchedRectangle(),
              child: Container(
                height: 75,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      iconSize: 50.0,
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => settings()));
                      },
                    ),
                    IconButton(
                      iconSize: 50.0,
                      icon: Icon(Icons.home),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => mainHome()));
                      },
                    ),
                    IconButton(
                      iconSize: 50.0,
                      icon: Icon(Icons.supervised_user_circle_outlined),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => userAccount()));
                      },
                    )
                  ],
                ),
              ))*/
      ),
    );
  }

  Stream _queryDb({String tag = 'Finance'}) {
    // Map the documents to the data payload
    slides = db
        .collection('home')
        .where('tags', arrayContains: tag)
        .snapshots()
        .map((list) => list.documents.map((doc) => doc.data));

    // Update the active tag
    setState(() {
      activeTag = tag;
    });
  }

  _buildTagPage() {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text('SERVICES', style: TextStyle(color: Colors.black26)),
        _buildButton('Finance'),
        _buildButton('Health'),
        _buildButton('Reminder'),
        _buildButton('To-Do List'),
        _buildButton('Travel'),
        _buildButton('Shopping'),
        _buildButton('Emergency'),
        _buildButton('Motivational'),
      ],
    ));
  }

  _buildButton(tag) {
    Color color = tag == activeTag ? Colors.blue : Colors.white;
    return FlatButton(color: color, child: Text('#$tag'), onPressed: () => _btnPress(tag));
  }

  _btnPress(String tag) {
    if (tag == "Finance") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => financeHome()));
    } else if (tag == "Health") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => medicalHome()));
    } else if (tag == "Reminder") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => reminders()));
    } else if (tag == "To-Do List") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskPage(
              user: FirebaseAuth.instance.currentUser,
            ),
          ));
    } else if (tag == "Travel") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyFlightInfoField()));
    } else if (tag == "Shopping") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => shopHome()));
    } else if (tag == "Emergency") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => emergency()));
    } else if (tag == "Motivational") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => motivation()));
    }
  }

  _buildStoryPage(String tag, bool active) {
    // Animated Properties
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 100 : 200;

    return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1569982175971-d92b01cf8694?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8NHx8fGVufDB8fHw%3D&w=1000&q=80'),
            ),
            boxShadow: [BoxShadow(color: Colors.black87, blurRadius: blur, offset: Offset(offset, offset))]),
        child: Center(child: Text("Hello", style: TextStyle(fontSize: 40, color: Colors.white))));
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = settings();
          // Navigator.push(context, MaterialPageRoute(builder: (context) => settings()));
          break;
        case 1:
          _child = Home();
          // Navigator.push(context, MaterialPageRoute(builder: (context) => mainHome()));
          break;
        case 2:
          _child = userAccount();
          // Navigator.push(context, MaterialPageRoute(builder: (context) => userAccount()));
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
