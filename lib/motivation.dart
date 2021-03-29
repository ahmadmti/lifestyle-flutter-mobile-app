import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lifestyle/userAccount.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/settings.dart';
import 'package:http/http.dart' as http;

class motivation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return motivationState();
  }
}

class motivationState extends State<motivation> {
  var quote = "Fetching quote...", owner = '';
  @override
  void initState() {
    super.initState();

    getQuote();
  }

  getQuote() async {
    try {
      var response = await http.post(Uri.encodeFull('https://api.forismatic.com/api/1.0/'),
          body: {"method": "getQuote", "format": "json", "lang": "en"});
      setState(() {
        try {
          var res = jsonDecode(response.body);
          owner = res["quoteAuthor"];
          quote = res["quoteText"];

          print("quote: $quote");
        } catch (e) {
          getQuote();
        }
      });
    } catch (e) {
      quote = "Failed: Unable to fetch quote";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Motivation Page'),
        ),
        // drawer: Drawer(
        //   child: ListView(
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
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "assets/images/quote.png",
              height: 150,
              width: 150,
              color: Colors.grey[300],
            ),
           
           Padding(padding: EdgeInsets.only(left: 10, right: 10),
           child:  Column(
              children: [
                Text(
                  quote,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "- $owner",
                  style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                )
              ],
            ),)
          ],
        )),
        // bottomNavigationBar: BottomAppBar(
        //     shape: CircularNotchedRectangle(),
        //     child: Container(
        //       height: 75,
        //       child: Row(
        //         mainAxisSize: MainAxisSize.max,
        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //         children: <Widget>[
        //           IconButton(
        //             iconSize: 50.0,
        //             icon: Icon(Icons.settings),
        //             onPressed: () {
        //               Navigator.push(context, MaterialPageRoute(builder: (context) => settings()));
        //             },
        //           ),
        //           IconButton(
        //             iconSize: 50.0,
        //             icon: Icon(Icons.home),
        //             onPressed: () {
        //               Navigator.push(context, MaterialPageRoute(builder: (context) => mainHome()));
        //             },
        //           ),
        //           IconButton(
        //             iconSize: 50.0,
        //             icon: Icon(Icons.supervised_user_circle_outlined),
        //             onPressed: () {
        //               Navigator.push(context, MaterialPageRoute(builder: (context) => userAccount()));
        //             },
        //           )
        //         ],
        //       ),
        //     ))
        //     ,
            );

    // get a random Quote from the API
  }
}
