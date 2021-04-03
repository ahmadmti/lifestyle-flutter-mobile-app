import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/settings.dart';
import 'package:lifestyle/todoList.dart';
import 'package:lifestyle/userAccount.dart';

import 'BirthdayReminder/new_entry_birthday.dart';
import 'home.dart';

class AddToDo extends StatefulWidget {
  final mToDo todo;
  AddToDo({this.todo});
  @override
  State<StatefulWidget> createState() {
    return AddToDoState();
  }
}

class AddToDoState extends State<AddToDo> {
  List<String> todos = [];
  var input;
  Widget _child;
  TextEditingController nameController;

  final FirebaseFirestore db = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    todos.add("item");
  }

  @override
  Widget build(BuildContext context) {
    nameController = TextEditingController(text: widget.todo != null ? widget.todo.content : '');

    return Center(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Add ToDo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PanelTitle(
              title: "ToDo",
              isRequired: true,
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              style: TextStyle(
                fontSize: 16,
              ),
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              child: FlatButton(
                  color: Colors.blue,
                  shape: StadiumBorder(),
                  child: Center(
                    child: Text(
                      widget.todo == null ? "Add ToDo" : "Update Todo",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if (widget.todo == null) {
                      String id = DateTime.now().millisecondsSinceEpoch.toString();
                      db.collection("ToDos").doc(firebaseUser.uid).collection("ToDos").doc().set({
                        "id": id,
                        "content": nameController.text,
                        "added_date": DateTime.now(),
                      }).then((_) {
                        Fluttertoast.showToast(
                            msg: "Added Successfully",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.pop(context);
                      });
                    } else {
                      db.collection("ToDos").doc(firebaseUser.uid).collection("ToDos").doc(widget.todo.id).set({
                        "content": nameController.text,
                      }).then((_) {
                        Fluttertoast.showToast(
                            msg: "Updated Successfully",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.pop(context);
                      });
                    }
                  }),
            )
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
}
