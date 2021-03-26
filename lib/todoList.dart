import 'package:flutter/material.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/settings.dart';
import 'package:lifestyle/userAccount.dart';

class todoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return todoListState();
  }
}

class todoListState extends State<todoList> {
  List todos =[];
  var input ;

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
                    accountName: new Text('Murtaza'),
                    accountEmail: new Text('murtaza.sharbat786@gmail.com'),
                    currentAccountPicture: new CircleAvatar(
                      backgroundImage: new NetworkImage('url'),
                    ),
                  ),
                  ListTile(
                    title: Text('About Page'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('User Settings'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            body: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                    key: todos[index],
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
            bottomNavigationBar: BottomAppBar(
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
                ))));
  }
}
