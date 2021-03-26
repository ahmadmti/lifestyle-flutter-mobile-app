//import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:lifestyle/authenticate/authenticate.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

var logger = Logger();
final authenticate _auth = authenticate();

// ignore: must_be_immutable
class CustomDialogBox extends StatefulWidget {
  var lable, valueParam, keyParam;

  CustomDialogBox({Key key, this.lable, this.valueParam, this.keyParam}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  final double padding = 10;
  final double avatarRadius = 45;
  final formKey = new GlobalKey<FormState>();
  final double blur = 30;
  final double offset = 20;
  TextEditingController _textEditingControllerUser = TextEditingController();
  TextEditingController _textEditingControllerPassword = TextEditingController();
  TextEditingController _textEditingControllerPasswordNew = TextEditingController();
  TextEditingController _textEditingControllerPasswordConfirm = TextEditingController();
  bool isNoVisiblePassword = true;

  var emailBtn = 'Update Email';
  var pwdBtn = 'Change Password';
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: AnimatedContainer(
        padding: EdgeInsets.only(left: padding, top: padding, right: padding, bottom: padding),
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        // margin: EdgeInsets.only(top: 50, bottom: 50, right: 0, left: 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage('https://i.stack.imgur.com/JHYTI.jpg'),
            ),
            boxShadow: [BoxShadow(color: Colors.black87, blurRadius: blur, offset: Offset(offset, offset))]),
        child: (widget.lable == "email")
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                        controller: this._textEditingControllerUser,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Color(0xFF0F2E48), fontSize: 14),
                        autofocus: false,
                        onSubmitted: (v) {
                          // FocusScope.of(context).requestFocus(focus);
                        },
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                "assets/images_login_fresh_34_/icon_user.png",
                                package: 'login_fresh',
                                width: 15,
                                height: 15,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Color(0xFFAAB5C3))),
                            filled: true,
                            fillColor: Color(0xFFF3F3F5),
                            focusColor: Color(0xFFF3F3F5),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Color(0xFFAAB5C3))),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Color(0xFFE7004C))),
                            hintText: "Email")),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        emailBtn = "Updating... Please wait";
                      });
                      await _auth.updateEmail(this._textEditingControllerUser.text);
                      // _updateEmail(this._textEditingControllerUser.text);
                      await usersRef
                          .child(FirebaseAuth.instance.currentUser.uid)
                          .child("email")
                          .set(this._textEditingControllerUser.text);
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setString('email', this._textEditingControllerUser.text);
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                          msg: "Email updated successfully",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    },
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            color: Color(0xFFE7004C),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Center(
                                  child: Text(
                                "$emailBtn",
                                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                            ))),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextField(
                        controller: this._textEditingControllerPassword,
                        obscureText: this.isNoVisiblePassword,
                        style: TextStyle(color: Color(0xFF0F2E48), fontSize: 14),
                        onSubmitted: (value) {},
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                "assets/images_login_fresh_34_/icon_password.png",
                                package: 'login_fresh',
                                width: 15,
                                height: 15,
                              ),
                            ),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (this.isNoVisiblePassword)
                                      this.isNoVisiblePassword = false;
                                    else
                                      this.isNoVisiblePassword = true;
                                  });
                                },
                                child: (this.isNoVisiblePassword)
                                    ? Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          "assets/images_login_fresh_34_/icon_eye_close.png",
                                          package: 'login_fresh',
                                          width: 15,
                                          height: 15,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          "assets/images_login_fresh_34_/icon_eye_open.png",
                                          package: 'login_fresh',
                                          width: 15,
                                          height: 15,
                                        ),
                                      )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Color(0xFFAAB5C3))),
                            filled: true,
                            fillColor: Color(0xFFF3F3F5),
                            focusColor: Color(0xFFF3F3F5),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Color(0xFFAAB5C3))),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Color(0xFFE7004C))),
                            hintText: "Current password")),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextField(
                        controller: this._textEditingControllerPasswordNew,
                        obscureText: this.isNoVisiblePassword,
                        style: TextStyle(color: Color(0xFF0F2E48), fontSize: 14),
                        onSubmitted: (value) {},
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                "assets/images_login_fresh_34_/icon_password.png",
                                package: 'login_fresh',
                                width: 15,
                                height: 15,
                              ),
                            ),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (this.isNoVisiblePassword)
                                      this.isNoVisiblePassword = false;
                                    else
                                      this.isNoVisiblePassword = true;
                                  });
                                },
                                child: (this.isNoVisiblePassword)
                                    ? Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          "assets/images_login_fresh_34_/icon_eye_close.png",
                                          package: 'login_fresh',
                                          width: 15,
                                          height: 15,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          "assets/images_login_fresh_34_/icon_eye_open.png",
                                          package: 'login_fresh',
                                          width: 15,
                                          height: 15,
                                        ),
                                      )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Color(0xFFAAB5C3))),
                            filled: true,
                            fillColor: Color(0xFFF3F3F5),
                            focusColor: Color(0xFFF3F3F5),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Color(0xFFAAB5C3))),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Color(0xFFE7004C))),
                            hintText: "New password")),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextField(
                        controller: this._textEditingControllerPasswordConfirm,
                        obscureText: this.isNoVisiblePassword,
                        style: TextStyle(color: Color(0xFF0F2E48), fontSize: 14),
                        onSubmitted: (value) {},
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                "assets/images_login_fresh_34_/icon_password.png",
                                package: 'login_fresh',
                                width: 15,
                                height: 15,
                              ),
                            ),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (this.isNoVisiblePassword)
                                      this.isNoVisiblePassword = false;
                                    else
                                      this.isNoVisiblePassword = true;
                                  });
                                },
                                child: (this.isNoVisiblePassword)
                                    ? Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          "assets/images_login_fresh_34_/icon_eye_close.png",
                                          package: 'login_fresh',
                                          width: 15,
                                          height: 15,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          "assets/images_login_fresh_34_/icon_eye_open.png",
                                          package: 'login_fresh',
                                          width: 15,
                                          height: 15,
                                        ),
                                      )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Color(0xFFAAB5C3))),
                            filled: true,
                            fillColor: Color(0xFFF3F3F5),
                            focusColor: Color(0xFFF3F3F5),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Color(0xFFAAB5C3))),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Color(0xFFE7004C))),
                            hintText: "Confirm password")),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();

                      if (prefs.getString("password") != _textEditingControllerPassword.text)
                        Fluttertoast.showToast(
                            msg: "Current password is incorrect",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      else if (_textEditingControllerPasswordNew.text.length <6 )
                        Fluttertoast.showToast(
                            msg: "New password must be 6 characters minimum",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      else if (_textEditingControllerPasswordNew.text != _textEditingControllerPasswordConfirm.text)
                        Fluttertoast.showToast(
                            msg: "New password doesn't match",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      else {
                        setState(() {
                          pwdBtn = "Updating... Please wait";
                        });
                        await _auth.updatePassword(this._textEditingControllerPasswordNew.text);

                        await prefs.setString('password', this._textEditingControllerPasswordNew.text);
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: "Password changed successfully",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            color: Color(0xFFE7004C),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Center(
                                  child: Text(
                                "$pwdBtn",
                                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                            ))),
                  ),
                ],
              ),
      ),
    );
  }
}
