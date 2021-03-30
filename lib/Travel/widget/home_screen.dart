import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/login/Login.dart';
import 'package:lifestyle/settings.dart';
import 'package:lifestyle/userAccount.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:lifestyle/Travel/view_model/calendar_view_model.dart';
import 'package:lifestyle/Travel/view_model/passenger_list_view_model.dart';
import 'package:lifestyle/Travel/view_model/search_view_model.dart';
import 'package:lifestyle/Travel/widget/flights_screen.dart';
import '../../main.dart';
import '../../mainHome.dart';
import 'departure_calendar_screen.dart';
import 'my_app_bar_widget.dart';
import 'return_caledar_screen.dart';
import 'open_passenger_list_widget.dart';
import 'search_airports_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lifestyle/Travel/widget/return_caledar_screen.dart';

class MyFlightInfoField extends StatefulWidget {
  @override
  _MyFlightInfoFieldState createState() => _MyFlightInfoFieldState();
}

class _MyFlightInfoFieldState extends State<MyFlightInfoField> {
  Widget _child;
  int currentPage = 0;
  String name = '';
  String n = '';
  @override
  void initState() {
    _child = mainHome();
    getData();
    super.initState();
  }

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

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = settings();

          break;
        case 1:
          _child = mainHome();

          break;
        case 2:
          _child = userAccount();

          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
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
                backgroundImage:
                    new NetworkImage('https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png'),
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
        padding: EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 10),
        child: Expanded(
          child: Column(
            children: [
              MyAppBar(),
              _departureNReturn(context),
              _selectDate(context),
              _divider(context),
              _fromTo(context),
              _displayAirports(context),
              Divider(
                thickness: 1,
                color: Colors.blue,
              ),
              _selectPassenger(context),
              _searchButton(context)
            ],
          ),
        ),
      ),
      // bottomNavigationBar: FluidNavBar(
      //   icons: [
      //     FluidNavBarIcon(icon: Icons.settings, backgroundColor: Colors.blue, extras: {"label": "settings"}),
      //     FluidNavBarIcon(icon: Icons.home, backgroundColor: Colors.blue, extras: {"label": "home"}),
      //     FluidNavBarIcon(
      //         icon: Icons.supervised_user_circle_outlined, backgroundColor: Colors.blue, extras: {"label": "account"}),
      //   ],
      //   onChange: _handleNavigationChange,
      //   style: FluidNavBarStyle(iconUnselectedForegroundColor: Colors.white, barBackgroundColor: Colors.grey[200]),
      //   scaleFactor: 1.5,
      //   defaultIndex: 1,
      //   itemBuilder: (icon, item) => Semantics(
      //     label: icon.extras["label"],
      //     child: item,
      //   ),
      // ),
    );
  }

  Future<String> _getInboundAirport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("inboundCity");
  }

  Future<String> _getInboundCityName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("inboundCityName");
  }

  Future<String> _getOutboundCityName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("shared preferences outbound city güncellendi ");
    return prefs.getString("outboundCityName");
  }

  Future<String> _getOutboundAirport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("outboundCity");
  }

  void _setDepartureDate(String departureDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("inboundDate", departureDate);
    print("inboundDate spye eklendi");
  }

  void _setReturnDate(String returnDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("outboundDate", returnDate);
    print("outboundDate spye eklendi");
  }

  _departureNReturn(BuildContext context) => Container(
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DepartureCalendar()));
                },
                child: Text("Departure", style: TextStyle(color: Colors.blue)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReturnCalendar()));
                },
                child: Text("Return", style: TextStyle(color: Colors.blue)),
              )
            ],
          ),
        ),
      );

  _selectDate(BuildContext context) => Container(
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DepartureCalendar()));
              }, child: Consumer<CalendarViewModel>(builder: (context, item, child) {
                String departureDate = item.selectedDeparuteDate.toString();
                _setDepartureDate(departureDate);
                return Text(
                  item.selectedDeparuteDate != null ? departureDate.substring(0, 10) : "Select date",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                );
              })),
              Icon(Icons.calendar_today, color: Colors.blue),
              FlatButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ReturnCalendar()));
              }, child: Consumer<CalendarViewModel>(builder: (context, item, child) {
                String returnDate = item.selectedReturnDate.toString();
                _setReturnDate(returnDate);
                return Text(
                  item.selectedReturnDate != null ? returnDate.substring(0, 10) : "Select date",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                );
              })),
            ],
          ),
        ),
      );

  _divider(BuildContext context) => Expanded(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
          Expanded(
              child: Divider(
            thickness: 1,
            color: Colors.blue,
          )),
          Text("         "),
          Expanded(
              child: Divider(
            thickness: 1,
            color: Colors.blue,
          )),
        ]),
      );

  _fromTo(BuildContext context) => Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchAirports());
              },
              child: Text(
                "From",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            TextButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchAirports());
              },
              child: Text("To", style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      );

  _displayAirports(BuildContext context) => Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                          child: Consumer<SearchViewModel>(builder: (context, item, child) {
                return TextButton(
                  onPressed: () {
                    item.searchNPrintResultInbound(
                      context,
                    );
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: FutureBuilder<String>(
                          future: _getInboundAirport(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            return FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                snapshot.data != null ? "${snapshot.data}" : "Select Airport",
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder<String>(
                          future: _getInboundCityName(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            return FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                snapshot.data != null ? "${snapshot.data}" : "Select Airport",
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            Icon(
              Icons.flight,
              color: Colors.blue,
            ),
            Expanded(
                          child: Consumer<SearchViewModel>(builder: (context, item, child) {
                return FlatButton(
                  onPressed: () {
                    context.read<SearchViewModel>().searchNPrintResultOutbound(context);
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: FutureBuilder<String>(
                          future: _getOutboundAirport(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            return FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                snapshot.data != null ? "${snapshot.data} " : "Select Airport",
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder<String>(
                          future: _getOutboundCityName(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            return Container(
                              child: Text(
                                snapshot.data != null ? "${snapshot.data} " : "",
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      );

  _selectPassenger(BuildContext context) => FlatButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OpenPassengerList(),
          ),
        );
      },
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Icon(Icons.person, size: 40, color: Colors.blue),
        ),
        title: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "\nSelect Passenger            ",
                    style: TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 200,
                    child: Consumer<ItemViewModel>(builder: (context, item, child) {
                      return FutureBuilder(
                          future: item.readPassengerValue(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data != null) {
                                return ListView.separated(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    String key = snapshot.data.keys.elementAt(index);
                                    return Text(
                                      "${snapshot.data[key]} $key ",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) => Divider(
                                    color: Colors.blue,
                                    thickness: 1,
                                  ),
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            } else {
                              return CircularProgressIndicator();
                            }
                          });
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ));

  _searchButton(BuildContext context) => Expanded(
        child: TextButton(
            child: Text(
              'SEARCH',

              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
                    decoration: TextDecoration.underline,

              ),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FligthScreen()));
            }),
      );
}
