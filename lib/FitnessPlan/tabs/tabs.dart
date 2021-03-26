import 'package:flutter/material.dart';
import 'package:lifestyle/FitnessPlan/tabs/Diet.dart';
import 'package:lifestyle/FitnessPlan/tabs/Programs.dart';
import 'package:lifestyle/FitnessPlan/tabs/Results.dart';

class Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: TabBarView(
          children: <Widget>[
            Programs(),

          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.explicit, size: 26.0),
            ),


          ],
          labelPadding: EdgeInsets.all(5.0),
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black12,
          indicatorWeight: 0.01,
        ),
      ),
    );
  }
}