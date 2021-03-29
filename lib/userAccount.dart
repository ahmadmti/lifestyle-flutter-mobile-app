import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker_widget/enum/image_picker_widget_shape.dart';
import 'package:image_picker_widget/image_picker_widget.dart';
import 'package:lifestyle/main.dart';

const String defaultAvatar =
    "https://img.pngio.com/fileblank-avatarpng-georgian-civil-code-commentary-avatarpng-400_400.png";

class userAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return userAccountState();
  }
}

class userAccountState extends State<userAccount> {
  var name , email , gender , dob , img;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
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
          ListTile(
            onTap: null,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.person,
                ),
              ],
            ),
            title: Text("Full Name"),
            subtitle: Text(name??''),
          ),
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
            subtitle: Text(email??''),
          ),
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
            subtitle: Text(gender??''),
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
            subtitle: Text(dob??''),
          ),
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
