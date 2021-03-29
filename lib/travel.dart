import 'package:flutter/material.dart';
import 'package:lifestyle/userAccount.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/settings.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main.dart';

// ignore: camel_case_types
class travel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return travelState();
  }
}

class travelState extends State<travel> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Travel"),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white54,
              child: Center(
                child: Column(
                  children: [
                    Card(
                      child: InkWell(
                        onTap: () {
                          url_launcher("https://www.emirates.com/ae/english/");
                        },
                        child: Image.asset("assets/travel_image/emirates.jpeg",
                            height: 200.0, width: 350.0),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        onTap: () {
                          url_launcher(
                              "https://www.britishairways.com/travel/home/public/en_ae/");
                        },
                        child: Image.asset(
                          "assets/travel_image/bristish.jpeg",
                          height: 200.0,
                          width: 350.0,
                        ),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        onTap: () {
                          // Perform some action
                          url_launcher("http://www.airindia.in/");
                        },
                        child: Image.asset(
                          "assets/travel_image/airindia.jpeg",
                          height: 200.0,
                          width: 350.0,
                        ),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        onTap: () {
                          // Perform some action
                          url_launcher("https://www.etihad.com/en-ae/");
                        },
                        child: Image.asset(
                          "assets/travel_image/eithad.jpeg",
                          height: 200.0,
                          width: 350.0,
                        ),
                      ),
                    ),

                    //CHANGE FROM HERE
                    Card(
                      child: InkWell(
                        onTap: () {
                          url_launcher("https://www.kuwaitairways.com/en");
                        },
                        child: Image.asset("assets/travel_image/kuwait.jpeg",
                            height: 200.0, width: 350.0),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        onTap: () {
                          url_launcher(
                              "https://www.singaporeair.com/en_UK/ae/home#/book/bookflight");
                        },
                        child: Image.asset(
                          "assets/travel_image/singapore.jpeg",
                          height: 200.0,
                          width: 350.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
          //               Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) => settings()));
          //             },
          //           ),
          //           IconButton(
          //             iconSize: 50.0,
          //             icon: Icon(Icons.home),
          //             onPressed: () {
          //               Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) => mainHome()));
          //             },
          //           ),
          //           IconButton(
          //             iconSize: 50.0,
          //             icon: Icon(Icons.supervised_user_circle_outlined),
          //             onPressed: () {
          //               Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) => userAccount()));
          //             },
          //           )
          //         ],
          //       ),
          //     )),
              ),
    );
  }
}
