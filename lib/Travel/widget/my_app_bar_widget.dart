import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [


          Container(
            alignment: Alignment.center,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'OneStop',
                  style: new TextStyle(
                      fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Travel',
                  style: new TextStyle(
                      fontSize: 28.0, color: Colors.blue),
                )
              ],
            ),
            margin: EdgeInsets.only(left: 20.0),
            height: 54.0,
          ),
        ],
      ),
    );
  }
}
