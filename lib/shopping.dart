import 'package:flutter/material.dart';
import 'package:lifestyle/userAccount.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/settings.dart';

import 'main.dart';

class shopping extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return shoppingState();
  }
}

class shoppingState extends State<shopping> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text("Shopping"),
          ),
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
                        url_launcher("https://www.gucci.com/ae/en_gb/");
                      },
                      child: Image.asset(
                          "assets/shopping_image/gucci_shopping.jpg",
                          height: 200.0,
                          width: 350.0),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: () {
                        url_launcher("https://www.armani.com/wx/armanicom");
                      },
                      child: Image.asset(
                        "assets/shopping_image/georgio_armani_logo.png",
                        height: 200.0,
                        width: 350.0,
                      ),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: () {
                        // Perform some action
                        url_launcher("https://www.splashfashions.com/ae/en");
                      },
                      child: Image.asset(
                        "assets/shopping_image/splash_logo.png",
                        height: 200.0,
                        width: 350.0,
                      ),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: () {
                        // Perform some action
                        url_launcher("https://www.maxfashion.com/ae/en");
                      },
                      child: Image.asset(
                        "assets/shopping_image/max_logo.png",
                        height: 200.0,
                        width: 350.0,
                      ),
                    ),
                  ),

                  //CHANGE FROM HERE
                  Card(
                    child: InkWell(
                      onTap: () {
                        url_launcher("https://www.americaneagle.ae/en/");
                      },
                      child: Image.asset(
                          "assets/shopping_image/american_eagle_outfit.jpg",
                          height: 200.0,
                          width: 350.0),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: () {
                        url_launcher("https://www.nike.com/ae/");
                      },
                      child: Image.asset(
                        "assets/shopping_image/nike_logo.png",
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => settings()));
                  },
                ),
                IconButton(
                  iconSize: 50.0,
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => mainHome()));
                  },
                ),
                IconButton(
                  iconSize: 50.0,
                  icon: Icon(Icons.supervised_user_circle_outlined),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => userAccount()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
