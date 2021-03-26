import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/login/Login.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

// providers
import '../../main.dart';
import '../providers/auth_provider.dart';
import '../providers/statistics_provider.dart';

// models
import '../models/weekly_data.dart';

// widgets
import '../widgets/custom_app_bar.dart';
import '../widgets/weekly_statistics_graph.dart';
import '../widgets/custom_progress_indicator.dart';
import '../widgets/three_layer_background.dart';

class StatisticsScreen extends StatefulWidget {
  final Function openDrawer;
  StatisticsScreen({this.openDrawer});

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    getData();
    init();
  }

  String name;
  String n;

  Future<String> getData() async {
    String n;
    await usersRef
        .reference()
        .child(FirebaseAuth.instance.currentUser.uid)
        .once()
        .then((DataSnapshot snapshot) => n = snapshot.value["name"]);

    setState(() {
      name = n;
    });

    return name;
  }

  void toggleLoading() {
    setState(() {
      _loading = !_loading;
    });
  }

  void init() async {
    toggleLoading();
    await Provider.of<StatisticsProvider>(context, listen: false).init();
    toggleLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text("OneStop"),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(name),
              accountEmail: new Text(FirebaseAuth.instance.currentUser.email),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage('url'),
              ),
            ),
            ListTile(
              title: Text('About Page'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Terms & Conditions'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Log Out'),
              onTap: () {
                Navigator.pop(context);
                FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => loginClass()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 5),
        child: _loading
            ? Center(
                child: CustomProgressIndicatior(),
              )
            : Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 25, 30, 30),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Statistics',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(fontSize: 25, letterSpacing: 1, fontWeight: FontWeight.w500),
                    ),
                  ),
                  //SizedBox(height: 30,),
                  Expanded(
                    child: Stack(
                      children: [
                        ThreeLayerBackground(),
                        Consumer<StatisticsProvider>(
                          builder: (context, statisticsProvider, child) {
                            List<WeeklyData> weeklyData = statisticsProvider.weeklyData;
                            return ListView.separated(
                              padding: EdgeInsets.fromLTRB(30, 40, 30, 40),
                              itemCount: weeklyData.length,
                              itemBuilder: (context, index) {
                                return WeeklyStatisticsGraph(weeklyData[index]);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 20,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
