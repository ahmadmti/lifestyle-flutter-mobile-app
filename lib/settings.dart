import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/userAccount.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Travel/widget/custom_dialog_box.dart';
import 'authenticate/authenticate.dart';
import 'login/Login.dart';

final authenticate _auth = authenticate();

var url =
    "https://faq.whatsapp.com/general/security-and-privacy/were-updating-our-terms-and-privacy-policy?campaign_id=12074681949&extra_1=s%7Cc%7C491604076779%7Cb%7C%2Bwhatsapp%20%2Bprivacy%7C&placement=&creative=491604076779&keyword=%2Bwhatsapp%20%2Bprivacy&partner_id=googlesem&extra_2=campaignid%3D12074681949%26adgroupid%3D113184190701%26matchtype%3Db%26network%3Dg%26source%3Dnotmobile%26search_or_content%3Ds%26device%3Dc%26devicemodel%3D%26adposition%3D%26target%3D%26targetid%3Dkwd-374388685640%26loc_physical_ms%3D1011082%26loc_interest_ms%3D%26feeditemid%3D%26param1%3D%26param2%3D";

class settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return settingsState();
  }
}

class settingsState extends State<settings> {
  bool _switchValue = false;
  var logout_btn = "Logout form OneStop";

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text("Settings"),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
            ),
            color: Colors.grey[300],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: Text(
                    "Account",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                InkWell(
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialogBox(
                          lable: "email",
                        );
                      }),
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        "Change Email",
                      ),
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialogBox(
                          lable: "pwd",
                        );
                      }),
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        "Change Password",
                      ),
                    ),
                  ),
                ),
                Divider(),
                Padding(
                    padding: EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Notification",
                        ),
                        Platform.isAndroid
                            ? Switch(
                                value: _switchValue,
                                onChanged: (value) {
                                  setState(() {
                                    _switchValue = value;
                                  });
                                },
                              )
                            : CupertinoSwitch(
                                value: _switchValue,
                                onChanged: (value) {
                                  setState(() {
                                    _switchValue = value;
                                    // pref.setUserType(value ? Utils.user_type_seller : Utils.user_type_buyer);
                                    // Timer(Duration(seconds: 1), () => Utils.pushAndRemoveUntil(HomePage(), context));
                                  });
                                },
                              ),
                      ],
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
            ),
            color: Colors.grey[300],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: Text(
                    "Legel Information",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                InkWell(
                  onTap: () => launchBrowser(url),
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        "Privacy Policy",
                      ),
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () => launchBrowser(url),
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        "Terms & Conditions",
                      ),
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () => launchBrowser(url),
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 5,
                        bottom: 15,
                      ),
                      child: Text(
                        "Disclaimer",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            splashColor: Colors.white,
            onTap: () async {
              setState(() {
                logout_btn = "Logging off...";
              });
              await _auth.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => loginClass()), (Route<dynamic> route) => false);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
              ),
              color: Colors.grey[300],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 15,
                    ),
                    child: Text(
                      "$logout_btn",
                      style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  launchBrowser(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
