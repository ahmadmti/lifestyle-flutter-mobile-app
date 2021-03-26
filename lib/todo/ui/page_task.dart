import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/login/Login.dart';
import 'package:lifestyle/todo/model/element.dart';
import 'package:lifestyle/todo/ui/page_detail.dart';

import '../../main.dart';
import '../../mainHome.dart';
import '../../settings.dart';
import '../../userAccount.dart';
import 'page_addlist.dart';

class TaskPage extends StatefulWidget {
  final User user;

  TaskPage({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with SingleTickerProviderStateMixin {
  Widget _child;
  int index = 1;
  String name = '';
  String n = '';

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
          child: Text("To-Do List"),
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
          _getToolbar(context),
          new Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30.0),
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
                              'Task',
                              style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Lists',
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
                padding: EdgeInsets.only(top: 50.0),
                child: new Column(
                  children: <Widget>[
                    new Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                          border: new Border.all(color: Colors.black38),
                          borderRadius: BorderRadius.all(Radius.circular(7.0))),
                      child: new IconButton(
                        icon: new Icon(Icons.add),
                        onPressed: _addTaskPressed,
                        iconSize: 30.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text('Add List', style: TextStyle(color: Colors.black45)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Container(
              height: 360.0,
              padding: EdgeInsets.only(bottom: 25.0),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                },
                child: new StreamBuilder<QuerySnapshot>(
                    stream:
                        Firestore.instance.collection(widget.user.uid).orderBy("date", descending: true).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData)
                        return new Center(
                            child: CircularProgressIndicator(
                          backgroundColor: Colors.blue,
                        ));
                      return new ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(left: 40.0, right: 40.0),
                        scrollDirection: Axis.horizontal,
                        children: getExpenseItems(snapshot),
                      );
                    }),
              ),
            ),
          ),
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

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<ElementTask> listElement = new List(), listElement2;
    Map<String, List<ElementTask>> userMap = new Map();

    List<String> cardColor = new List();

    if (widget.user.uid.isNotEmpty) {
      cardColor.clear();

      snapshot.data.documents.map<List>((f) {
        String color;
        f.data().forEach((a, b) {
          if (b.runtimeType == bool) {
            listElement.add(new ElementTask(a, b));
          }
          if (b.runtimeType == String && a == "color") {
            color = b;
          }
        });
        listElement2 = new List<ElementTask>.from(listElement);
        for (int i = 0; i < listElement2.length; i++) {
          if (listElement2.elementAt(i).isDone == false) {
            userMap[f.documentID] = listElement2;
            cardColor.add(color);
            break;
          }
        }
        if (listElement2.length == 0) {
          userMap[f.documentID] = listElement2;
          cardColor.add(color);
        }
        listElement.clear();
      }).toList();

      return new List.generate(userMap.length, (int index) {
        return new GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              new PageRouteBuilder(
                pageBuilder: (_, __, ___) => new DetailPage(
                  user: widget.user,
                  i: index,
                  currentList: userMap,
                  color: cardColor.elementAt(index),
                ),
                transitionsBuilder: (context, animation, secondaryAnimation, child) => new ScaleTransition(
                  scale: new Tween<double>(
                    begin: 1.5,
                    end: 1.0,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Interval(
                        0.50,
                        1.00,
                        curve: Curves.linear,
                      ),
                    ),
                  ),
                  child: ScaleTransition(
                    scale: Tween<double>(
                      begin: 0.0,
                      end: 1.0,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Interval(
                          0.00,
                          0.50,
                          curve: Curves.linear,
                        ),
                      ),
                    ),
                    child: child,
                  ),
                ),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            color: Color(int.parse(cardColor.elementAt(index))),
            child: new Container(
              width: 220.0,
              //height: 100.0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
                      child: Container(
                        child: Text(
                          userMap.keys.elementAt(index),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.only(left: 50.0),
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30.0, left: 15.0, right: 5.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 220.0,
                            child: ListView.builder(
                                //physics: const NeverScrollableScrollPhysics(),
                                itemCount: userMap.values.elementAt(index).length,
                                itemBuilder: (BuildContext ctxt, int i) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        userMap.values.elementAt(index).elementAt(i).isDone
                                            ? FontAwesomeIcons.checkCircle
                                            : FontAwesomeIcons.circle,
                                        color: userMap.values.elementAt(index).elementAt(i).isDone
                                            ? Colors.white70
                                            : Colors.white,
                                        size: 14.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                      ),
                                      Flexible(
                                        child: Text(
                                          userMap.values.elementAt(index).elementAt(i).name,
                                          style: userMap.values.elementAt(index).elementAt(i).isDone
                                              ? TextStyle(
                                                  decoration: TextDecoration.lineThrough,
                                                  color: Colors.white70,
                                                  fontSize: 17.0,
                                                )
                                              : TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17.0,
                                                ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
    }
  }

  void _addTaskPressed() async {
    Navigator.of(context).push(
      new PageRouteBuilder(
        pageBuilder: (_, __, ___) => new NewTaskPage(
          user: widget.user,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => new ScaleTransition(
          scale: new Tween<double>(
            begin: 1.5,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Interval(
                0.50,
                1.00,
                curve: Curves.linear,
              ),
            ),
          ),
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Interval(
                  0.00,
                  0.50,
                  curve: Curves.linear,
                ),
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
    //Navigator.of(context).pushNamed('/new');
  }

  Padding _getToolbar(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        new Image(width: 60.0, height: 60.0, fit: BoxFit.cover, image: new AssetImage('assets/logo2.png')),
      ]),
    );
  }
}
