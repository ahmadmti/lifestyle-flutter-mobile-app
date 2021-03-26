import 'package:flutter/material.dart';

class Header extends StatelessWidget {

  final String title;
  final Widget rightSide;

  Header(this.title, {this.rightSide});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
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
                'Fitness',
                style: new TextStyle(
                    fontSize: 28.0, color: Colors.blue),
              )
            ],
          ),
          margin: EdgeInsets.only(left: 20.0),
          height: 54.0,
        ),
        (this.rightSide != null) ? this.rightSide : Container()
      ],
    );
  }
}
