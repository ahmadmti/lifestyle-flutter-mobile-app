import 'package:flutter/material.dart';
import 'package:lifestyle/Reminder/MedicalReminder/global_bloc.dart';
import 'package:lifestyle/Reminder/MedicalReminder/ui/homepage/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MedicineReminder());
}

class MedicineMain extends StatefulWidget {
  @override
  _MedicineMain createState() => _MedicineMain();
}

class _MedicineMain extends State<MedicineMain> {
  GlobalBloc globalBloc;

  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        home: MedicineReminder(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
