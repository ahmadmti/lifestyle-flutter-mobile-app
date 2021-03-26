import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/WaterReminder/screens/scatistics_screen.dart';
import 'package:lifestyle/login/Login.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lifestyle/main.dart';
// widgets
import '../widgets/custom_app_bar.dart';
import '../widgets/goal_and_add.dart';
import '../widgets/weather_suggestion.dart';
import '../widgets/loading_screen.dart';

// providers
import '../providers/home_provider.dart';
import '../providers/auth_provider.dart';

// models
import '../models/app_user.dart';

// widgets
import '../widgets/custom_progress_indicator.dart';
import '../widgets/custom_form_field.dart';

class HomeScreen extends StatefulWidget {
  final Function openDrawer;
  HomeScreen({this.openDrawer});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    init();
    getData();
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
      _isLoading = !_isLoading;
    });
  }

  void init() async {
    toggleLoading();
    await Provider.of<HomeProvider>(context, listen: false).init();
    toggleLoading();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingScreen()
        : Scaffold(
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
              padding: EdgeInsets.only(top: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GoalAndAdd(),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(padding: const EdgeInsets.fromLTRB(30, 0, 30, 20), child: WeatherSuggestion())
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                elevation: 3,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.add,
                  size: 30,
                ),
                onPressed: () {
                  //Navigator.of(context).pushNamed(AddWaterScreen.routeName);
                  showDialog(
                      context: context,
                      builder: (BuildContext ctx) {
                        return AddWaterWidget();
                      });
                }),
          );
  }
}

class AddWaterWidget extends StatefulWidget {
  @override
  _AddWaterWidgetState createState() => _AddWaterWidgetState();
}

class _AddWaterWidgetState extends State<AddWaterWidget> {
  bool _loading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // data
  DateTime _time = DateTime.now();
  int _water;

  void toggleLoading() {
    setState(() {
      _loading = !_loading;
    });
  }

  void submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    toggleLoading();
    try {
      await Provider.of<HomeProvider>(context, listen: false).addWater(_water, _time);
      Navigator.of(context).pop();
      return;
    } catch (e) {
      print(e);
    }
    toggleLoading();
  }

  @override
  Widget build(BuildContext context) {
    AppUser appUser = Provider.of<HomeProvider>(context).appUser;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Text(
            'Add Water',
            style: GoogleFonts.poppins(fontSize: 14),
          ),
          SizedBox(
            height: 20,
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    DateTime date = await showDatePicker(
                      context: context,
                      initialDate: _time,
                      firstDate: DateTime(1960),
                      lastDate: _time,
                    );
                    if (date != null && date.isBefore(DateTime.now())) {
                      setState(() {
                        _time = date;
                      });
                    }
                  },
                  child: CustomFormField(
                      label: 'Date',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat.yMMMd('en_US').format(_time),
                            style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormField(
                  label: 'Water',
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '240 mL',
                      suffixText: 'mL',
                    ),
                    style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter water amount';
                      }
                      if (double.parse(value) <= 0) {
                        return 'Wrong value';
                      }
                      if (double.parse(value) > appUser.dailyTarget) {
                        return 'Daily limit exceed';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      setState(() {
                        _water = int.parse(value);
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      actions: <Widget>[
        FlatButton(
          textColor: Colors.blue,
          child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          color: Colors.blue,
          child: _loading
              ? SizedBox(height: 22, width: 22, child: CustomProgressIndicatior())
              : Text('Add', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
          onPressed: submit,
        ),
      ],
    );
  }
}
