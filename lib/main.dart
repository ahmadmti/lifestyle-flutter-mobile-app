import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lifestyle/Travel/locator.dart';
import 'package:lifestyle/Travel/view_model/calendar_view_model.dart';
import 'package:lifestyle/Travel/view_model/passenger_list_view_model.dart';
import 'package:lifestyle/Travel/view_model/search_view_model.dart';
import 'package:lifestyle/welcomepage.dart';
import 'package:lifestyle/Health/DietPlan/dietPlan.dart';
import 'package:lifestyle/Health/DietPlan/dietDetialScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import 'Travel/view_model/airport_view_model.dart';
import 'WaterReminder/providers/auth_provider.dart';
import 'WaterReminder/providers/home_provider.dart';
import 'WaterReminder/providers/statistics_provider.dart';

Future<void> main() async {
  setUpLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings android = AndroidInitializationSettings('logo');
  IOSInitializationSettings ios = IOSInitializationSettings();
  InitializationSettings settings = InitializationSettings(
      android: android,iOS: ios
  );
  await notificationsPlugin.initialize(
    settings,
  );

  print (FirebaseAuth.instance.currentUser);
  runApp(MyApp());
}

void url_launcher(String Url) async {
  if (await canLaunch(Url)) {
    await launch(Url);
  } else {
    throw 'Could Not open the link';
  }
}
DatabaseReference usersRef=FirebaseDatabase.instance.reference().child("users");
class MyApp extends StatelessWidget {
  static FlutterLocalNotificationsPlugin notifications =
  FlutterLocalNotificationsPlugin();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider<AuthProvider>(
        create: (context) => AuthProvider(),
    ),
    ChangeNotifierProxyProvider<AuthProvider,HomeProvider>(
    create: (context) => HomeProvider(),
    update: (context, authProvider, homeProvider) => homeProvider..update(authProvider.user),
    ),
    ChangeNotifierProxyProvider<AuthProvider,StatisticsProvider>(
    create: (context) => StatisticsProvider(),
    update: (context, authProvider, statisticsProvider) => statisticsProvider..update(authProvider.user),
    ),
          ChangeNotifierProvider<AirportViewModel>(
              create: (context) => locator<AirportViewModel>()),
          ChangeNotifierProvider<ItemViewModel>(
              create: (context) => locator<ItemViewModel>()),
          ChangeNotifierProvider<SearchViewModel>(
              create: (context) => locator<SearchViewModel>()),
          ChangeNotifierProvider<CalendarViewModel>(
              create: (context) => locator<CalendarViewModel>()),
    ],

      child:MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: welcomePage(),
      routes: <String, WidgetBuilder>{
        '/dietPlan': (BuildContext context) => new dietPlan(),
        '/dietDetialScreen': (BuildContext context) => new dietDetialScreen(),
      },
    )

    );
  }
  void _initializeLocalNotificationsPlugin(BuildContext context) {
    var settingsAndroid = AndroidInitializationSettings('ic_stat_alarm');
    var settingsIOS = IOSInitializationSettings();
    notifications.initialize(
      InitializationSettings(android:settingsAndroid, iOS:settingsIOS),
      onSelectNotification: (payload) {
        _onSelectNotification(context, payload);
      },
    );
  }

  Future _onSelectNotification(BuildContext context, String payload) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }
}
