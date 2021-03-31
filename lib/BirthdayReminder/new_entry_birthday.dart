import 'dart:async';
import 'dart:math';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/BirthdayReminder/new_entry_birthday_bloc.dart';
import 'package:lifestyle/FitnessPlan/calculator/screens/homePage.dart';
import 'package:lifestyle/Reminder/MedicalReminder/common/convert_time.dart';
import 'package:lifestyle/Reminder/MedicalReminder/global_bloc.dart';
import 'package:lifestyle/Reminder/MedicalReminder/models/birthday.dart';
import 'package:lifestyle/Reminder/MedicalReminder/models/errors.dart';
import 'package:lifestyle/Reminder/MedicalReminder/models/medicine.dart';
import 'package:lifestyle/Reminder/MedicalReminder/models/medicine_type.dart';
import 'package:lifestyle/Reminder/MedicalReminder/ui/new_entry/new_entry_bloc.dart';
import 'package:lifestyle/Reminder/MedicalReminder/ui/success_screen/success_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../home.dart';
import '../mainHome.dart';
import '../settings.dart';
import '../userAccount.dart';
import 'birthday_reminder_bloc.dart';

class NewEntryBirthday extends StatefulWidget {
  final Birthday birthday;
  final int index;
  NewEntryBirthday({this.birthday, this.index=-1});

  @override
  _NewEntryBirthdayState createState() => _NewEntryBirthdayState();
}

class _NewEntryBirthdayState extends State<NewEntryBirthday> {
  TextEditingController nameController;
  TextEditingController noteController;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  NewEntryBirthdayBloc _newEntryBloc;
  Widget _child;

  GlobalKey<ScaffoldState> _scaffoldKey;

  void dispose() {
    super.dispose();
    nameController.dispose();
    noteController.dispose();
    _newEntryBloc.dispose();
  }

  void initState() {
    super.initState();
    _newEntryBloc = NewEntryBirthdayBloc();
    nameController = TextEditingController(text: widget.birthday != null ? widget.birthday.birthdayName : '');
    noteController = TextEditingController(text: widget.birthday != null ? widget.birthday.birthdayNote : '');
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _scaffoldKey = GlobalKey<ScaffoldState>();

    initializeErrorListen();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBlocBirthday _globalBloc = Provider.of<GlobalBlocBirthday>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          "Add New Reminders",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Container(
        child: Provider<NewEntryBirthdayBloc>.value(
          value: _newEntryBloc,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              PanelTitle(
                title: "Birthday Name",
                isRequired: true,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 16,
                ),
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                ),
              ),
              PanelTitle(
                title: "Note",
                isRequired: false,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: noteController,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),

              PanelTitle(
                title: "Interval Selection",
                isRequired: true,
              ),
              SizedBox(
                height: 15,
              ),
              //ScheduleCheckBoxes(),
              IntervalSelection(birthday: widget.birthday != null ? widget.birthday : null),
              SizedBox(
                height: 20,
              ),
              PanelTitle(
                title: "Reminder Date",
                isRequired: true,
              ),
              SelectDate(birthday: widget.birthday != null ? widget.birthday : null),
              SizedBox(
                height: 15,
              ),

              PanelTitle(
                title: "Reminder Time",
                isRequired: true,
              ),
              SelectTime(birthday: widget.birthday != null ? widget.birthday : null),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Container(
                  width: 220,
                  height: 70,
                  child: FlatButton(
                    color: Colors.blue,
                    shape: StadiumBorder(),
                    child: Center(
                      child: Text(
                        "Add Birthday",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      //--------------------Error Checking------------------------
                      //Had to do error checking in UI
                      //Due to unoptimized BLoC value-grabbing architecture
                      if (nameController.text == "") {
                        _newEntryBloc.submitError(EntryError.NameNull);
                        return;
                      }

                      String birthdayName;
                      if (nameController.text != "") {
                        birthdayName = nameController.text;
                      }

                      String birthdayNote = noteController.text;

                      var selectedInterval;
                      _newEntryBloc.selectedInterval$.forEach((element) {
                        selectedInterval = element;
                      });

                      var selectedTimeOfDay;
                      _newEntryBloc.selectedTimeOfDay$.forEach((element) {
                        selectedTimeOfDay = element;
                      });

                      var selectedDate;
                      _newEntryBloc.selectedDate$.forEach((element) {
                        selectedDate = element;
                      });

                      //---------------------------------------------------------

                      Timer(Duration(seconds: 1), () {
                        if (selectedInterval == 0) {
                          _newEntryBloc.submitError(EntryError.Interval);
                          return;
                        }

                        if (selectedTimeOfDay == "None") {
                          _newEntryBloc.submitError(EntryError.StartTime);
                          return;
                        }

                        if (selectedDate == "None") {
                          _newEntryBloc.submitError(EntryError.StartDate);
                          return;
                        }

                        List<int> intIDs = makeIDs(24 / selectedInterval);
                        List<String> notificationIDs = intIDs.map((i) => i.toString()).toList(); //for Shared preference

                        Birthday newEntryBirthday = Birthday(
                          notificationIDs: notificationIDs,
                          birthdayName: birthdayName,
                          birthdayNote: birthdayNote,
                          interval: selectedInterval,
                          time: selectedTimeOfDay,
                          date: selectedDate,
                        );

                        _globalBloc.updateBirthdayList(newEntryBirthday, widget.index);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return SuccessScreen();
                            },
                          ),
                        );
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FluidNavBar(
        icons: [
          FluidNavBarIcon(icon: Icons.settings, backgroundColor: Colors.blue, extras: {"label": "settings"}),
          FluidNavBarIcon(icon: Icons.home, backgroundColor: Colors.blue, extras: {"label": "home"}),
          FluidNavBarIcon(
              icon: Icons.supervised_user_circle_outlined, backgroundColor: Colors.blue, extras: {"label": "account"})
        ],
        onChange: _handleNavigationChange,
        style: FluidNavBarStyle(iconUnselectedForegroundColor: Colors.white, barBackgroundColor: Colors.grey[200]),
        scaleFactor: 1.5,
        defaultIndex: 1,
        itemBuilder: (icon, item) => Semantics(
          label: icon.extras["label"],
          child: item,
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = settings();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => mainHome(index: 0)), (Route<dynamic> route) => false);
          break;

        case 1:
          _child = Home();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => mainHome(index: 1)), (Route<dynamic> route) => false);
          break;

        case 2:
          _child = userAccount();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => mainHome(index: 2)), (Route<dynamic> route) => false);
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

  void initializeErrorListen() {
    _newEntryBloc.errorState$.listen(
      (EntryError error) {
        switch (error) {
          case EntryError.NameNull:
            displayError("Please enter the name");
            break;
          case EntryError.NameDuplicate:
            displayError("Medicine name already exists");
            break;
          case EntryError.Dosage:
            displayError("Please enter the dosage required");
            break;
          case EntryError.Interval:
            displayError("Please select the reminder's interval");
            break;
          case EntryError.StartDate:
            displayError("Please select the reminder's date");
            break;
          case EntryError.StartTime:
            displayError("Please select the reminder's time");
            break;
          default:
        }
      },
    );
  }

  void displayError(String error) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(error),
        duration: Duration(milliseconds: 2000),
      ),
    );
  }

  List<int> makeIDs(double n) {
    var rng = Random();
    List<int> ids = [];
    for (int i = 0; i < n; i++) {
      ids.add(rng.nextInt(1000000000));
    }
    return ids;
  }
}

class IntervalSelection extends StatefulWidget {
  final Birthday birthday;
  IntervalSelection({this.birthday});

  @override
  _IntervalSelectionState createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  var _intervals = [
    1,
    6,
    8,
    10,
    12,
    24,
  ];
  var _selected = 0;

  @override
  void initState() {
    super.initState();
    if (widget.birthday != null) {
      print("interval: ${widget.birthday.interval}");
      _selected = widget.birthday.interval;
    }
  }

  @override
  Widget build(BuildContext context) {
    final NewEntryBirthdayBloc _newEntryBloc = Provider.of<NewEntryBirthdayBloc>(context);

    if (widget.birthday != null) {
      _newEntryBloc.updateInterval(_selected);
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Remind me before",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            DropdownButton<int>(
              iconEnabledColor: Colors.blue,
              hint: _selected == 0
                  ? Text(
                      "Select Interval",
                      style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
                    )
                  : null,
              elevation: 4,
              value: _selected == 0 ? null : _selected,
              items: _intervals.map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    "${value.toString()}h",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  _selected = newVal;
                  _newEntryBloc.updateInterval(newVal);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SelectDate extends StatefulWidget {
  final Birthday birthday;
  SelectDate({this.birthday});

  @override
  _SelectDateState createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  var _date;
  bool _clicked = false;
  NewEntryBirthdayBloc _newEntryBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    // if (widget.birthday != null) {
    //   _date = widget.birthday.date;
    // }
  }

  @override
  Widget build(BuildContext context) {
    _newEntryBloc = Provider.of<NewEntryBirthdayBloc>(context);
    if (widget.birthday != null) _newEntryBloc.updateDate(widget.birthday.date);

    return Container(
      height: 60,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: 0),
        child: FlatButton(
          color: Colors.blue,
          shape: StadiumBorder(),
          onPressed: () {
            showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              initialDate: DateTime.now(),
              lastDate: DateTime(3000),
            ).then((value) {
              if (value != null && value != _date) {
                setState(() {
                  _date = DateFormat('dd-MM-yyyy').format(value);
                  _clicked = true;

                  _newEntryBloc.updateDate(_date);
                });
              }
            });
          },
          child: Center(
            child: Text(
              (widget.birthday != null)
                  ? widget.birthday.date
                  : _clicked == false
                      ? "Pick Date"
                      : "$_date",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectTime extends StatefulWidget {
  final Birthday birthday;
  SelectTime({this.birthday});

  @override
  _SelectTimeState createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay _time = TimeOfDay(hour: 0, minute: 00);
  bool _clicked = false;
  NewEntryBirthdayBloc _newEntryBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    _newEntryBloc = Provider.of<NewEntryBirthdayBloc>(context);
    if ((widget.birthday != null)) _newEntryBloc.updateTime(widget.birthday.time);

    return Container(
      height: 60,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: 0),
        child: FlatButton(
          color: Colors.blue,
          shape: StadiumBorder(),
          onPressed: () {
            // _selectTime(context);
            showTimePicker(
              context: context,
              initialTime: _time,
            ).then((value) {
              if (value != null && value != _time) {
                setState(() {
                  _time = value;
                  _clicked = true;

                  _newEntryBloc
                      .updateTime("${convertTime(_time.hour.toString())}" + "${convertTime(_time.minute.toString())}");
                });
              }
            });
          },
          child: Center(
            child: Text(
              (widget.birthday == null)
                  ? _clicked == false
                      ? "Pick Time"
                      : "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}"
                  : (widget.birthday.time.toString().substring(0, 2) +
                      ":" +
                      widget.birthday.time.toString().substring(2, 4)),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PanelTitle extends StatelessWidget {
  final String title;
  final bool isRequired;
  PanelTitle({
    Key key,
    @required this.title,
    @required this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 4),
      child: Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: isRequired ? " *" : "",
            style: TextStyle(fontSize: 14, color: Colors.blue),
          ),
        ]),
      ),
    );
  }
}
