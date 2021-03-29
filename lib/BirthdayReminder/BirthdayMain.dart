import 'package:flutter/material.dart';
import 'package:lifestyle/BirthdayReminder/birthday_reminder_bloc.dart';
import 'package:lifestyle/Reminder/MedicalReminder/global_bloc.dart';
import 'package:lifestyle/Reminder/MedicalReminder/ui/homepage/homepage.dart';
import 'package:provider/provider.dart';

import 'birthdayHome.dart';

void main() {
  runApp(birthdayHome());
}

class BirthdayMain extends StatefulWidget {
  @override
  _MedicineMain createState() => _MedicineMain();
}

class _MedicineMain extends State<BirthdayMain> {
  GlobalBlocBirthday globalBloc;

  void initState() {
    globalBloc = GlobalBlocBirthday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBlocBirthday>.value(
      value: globalBloc,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        home: birthdayHome(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
