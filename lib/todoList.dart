import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/settings.dart';
import 'package:lifestyle/userAccount.dart';

import 'home.dart';

class todoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return todoListState();
  }
}

class todoListState extends State<todoList> {
  List<String> todos =[];
  var input ;
  Widget _child;

  @override
  void initState() {
    super.initState();
    todos.add("item");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
            appBar: AppBar(
              title: Text("To-Do List"),
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
            //         title: Text('User Settings'),
            //         onTap: () {
            //           Navigator.pop(context);
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            body: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                    key: Key(todos[index]),
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                          title: Text(todos[index]),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                todos.removeAt(index);
                              });
                            },
                          )),
                    ));
              },
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
