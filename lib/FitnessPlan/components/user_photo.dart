import 'package:flutter/material.dart';
import 'package:lifestyle/FitnessPlan/calculator/screens/homePage.dart';

class UserPhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));},
      child: Container(
        width: 60,
        height: 60,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/calcImage.jpg',
            ),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(400),
          ),
          color: Colors.redAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 20.0,
              offset: Offset(2.0, 2.0),
            ),
          ],
          border: Border.all(
            color: Colors.white,
            width: 4.0,
          ),
        ),
      ),
    );
  }
}