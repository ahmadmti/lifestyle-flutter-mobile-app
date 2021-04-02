import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker_widget/enum/image_picker_widget_shape.dart';
import 'package:image_picker_widget/image_picker_widget.dart';
import 'package:intl/intl.dart';
import 'package:lifestyle/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authenticate/authenticate.dart';

const String defaultAvatar =
    "https://img.pngio.com/fileblank-avatarpng-georgian-civil-code-commentary-avatarpng-400_400.png";

final authenticate _auth = authenticate();

var genderMap = <String>[
  'Male',
  'Female',
  'Other',
 
];

class userAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return userAccountState();
  }
}

class userAccountState extends State<userAccount> {
  bool editName = false;
  bool editEmail = false;
  bool editGender = false;
  var _date;
  String _selectedCat ;

  var name, email, gender, dob, img;
  String nameChange;
  TextEditingController nameController;
  TextEditingController emailController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    nameController = TextEditingController(text: name ?? '');
    emailController = TextEditingController(text: email ?? '');
    return Center(
        child: Scaffold(
      body: ListView(
        children: [
          Center(
            child: Container(
              width: 120,
              height: 120,
              margin: EdgeInsets.only(top: 30, bottom: 30),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8.0,
                    offset: Offset(0.0, 5.0),
                  ),
                ],
              ),
              child: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: ImagePickerWidget(
                    diameter: 120,
                    initialImage: img ?? defaultAvatar,
                    shape: ImagePickerWidgetShape.circle, // ImagePickerWidgetShape.square
                    isEditable: true,
                    onChange: (File file) {
                      if (file != null) _updateProfileImg(file);
                    },
                  )),
            ),
          ),
          ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.person,
                  ),
                ],
              ),
              title: Text("Full Name"),
              subtitle: !editName
                  ? Text(name ?? '')
                  : TextFormField(
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      autofocus: true,
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      // onSaved: (input) => nameChange = input,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
              trailing: !editName
                  ? IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        editName = true;

                        setState(() {});
                      })
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: Icon(Icons.save),
                            onPressed: () {
                              print("name: ${nameController.text}");
                              usersRef
                                  .child(FirebaseAuth.instance.currentUser.uid)
                                  .child("name")
                                  .set(nameController.text)
                                  .then((_) {
                                editName = false;
                                name = nameController.text;
                                setState(() {
                                  Fluttertoast.showToast(
                                      msg: "Name updated successfully",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                });
                              });
                            }),
                        IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              editName = false;
                              setState(() {});
                            }),
                      ],
                    )),
          Divider(),
          ListTile(
              onTap: null,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.mail_rounded,
                  ),
                ],
              ),
              title: Text("Email Address"),
              subtitle: !editEmail
                  ? Text(email ?? '')
                  : TextFormField(
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      autofocus: true,
                      controller: emailController,
                      textCapitalization: TextCapitalization.words,
                      // onSaved: (input) => nameChange = input,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
              trailing: !editEmail
                  ? IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        editEmail = true;

                        setState(() {});
                      })
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: Icon(Icons.save),
                            onPressed: () {
                              _auth.updateEmail(this.emailController.text).then((value) {
                                usersRef
                                    .child(FirebaseAuth.instance.currentUser.uid)
                                    .child("email")
                                    .set(emailController.text)
                                    .then((_) async {
                                  editEmail = false;
                                  email = emailController.text;
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  await prefs.setString('email', this.emailController.text);
                                  setState(() {
                                    Fluttertoast.showToast(
                                        msg: "Email updated successfully",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  });
                                });
                              });
                            }),
                        IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              editEmail = false;
                              setState(() {});
                            }),
                      ],
                    )),
          Divider(
              // color: Colors.black
              ),
          ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.person,
                ),
              ],
            ),
            title: Text("Gender"),
            subtitle: !editGender
                  ? Text(gender ?? '')
                  : DropdownButton<String>(
                      iconEnabledColor: Colors.blue,
                      hint: Text(
                              "Select one",
                              style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
                            ),
                      elevation: 4,
                      value:  _selectedCat,
                      items: genderMap.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            "$value",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          _selectedCat = newVal;
                          
                        });
                      },
                    ),

                    trailing: !editGender
                  ? IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        editGender = true;

                        setState(() {});
                      })
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: Icon(Icons.save),
                            onPressed: () {
                              usersRef.child(FirebaseAuth.instance.currentUser.uid).child("gender").set(_date).then((_) async {
                            setState(() {
                              gender = _selectedCat;
                                editGender = false;
                              Fluttertoast.showToast(
                                  msg: "Updated successfully",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            });
                          });
                            }),
                        IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              editGender = false;
                              setState(() {});
                            }),
                      ],
                    )
          ),
          Divider(
              // color: Colors.black
              ),
          ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                  ),
                ],
              ),
              title: Text("Date of Birth"),
              subtitle: Text(dob ?? ''),
              trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      initialDate: DateTime.now(),
                      lastDate: DateTime(3000),
                    ).then((value) {
                      if (value != null && value != _date) {
                        setState(() {
                          _date = DateFormat('dd-MM-yyyy').format(value);

                          usersRef.child(FirebaseAuth.instance.currentUser.uid).child("dob").set(_date).then((_) async {
                            setState(() {
                              dob = _date;
                              Fluttertoast.showToast(
                                  msg: "Updated successfully",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            });
                          });
                        });
                      }
                    });
                  })),
        ],
      ),
    ));
  }

  void getUserData() async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // var uid = pref.getString("uid");
    // var db = FirebaseDatabase.instance.reference().child("users").child(uid);
    // db.once().then((DataSnapshot snapshot) {
    //   print(snapshot);

    //   Map<dynamic, dynamic> values = snapshot.value;
    //   values.forEach((key, values) {
    //     print(values["email"]);

    //   });
    // });

    await usersRef.reference().child(FirebaseAuth.instance.currentUser.uid).once().then((DataSnapshot snapshot) {
      print(snapshot);
      name = snapshot.value["name"];
      email = snapshot.value["email"];
      dob = snapshot.value["dob"];
      gender = snapshot.value["gender"];
      img = snapshot.value["img"];
      setState(() {
        print("img: $img");
      });
    });
  }

  void _updateProfileImg(file) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("profile_images")
        .child(FirebaseAuth.instance.currentUser.uid)
        .child("img");

    UploadTask uploadTask = ref.putFile(file);
    uploadTask.whenComplete(() {
      ref.getDownloadURL().then((value) async {
        await usersRef.child(FirebaseAuth.instance.currentUser.uid).child("img").set(value);
        Fluttertoast.showToast(
            msg: "Uploading Successful",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    });
  }
}
