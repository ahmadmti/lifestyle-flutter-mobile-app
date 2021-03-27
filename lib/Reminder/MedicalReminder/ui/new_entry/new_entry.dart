import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lifestyle/FitnessPlan/calculator/screens/homePage.dart';
import 'package:lifestyle/Reminder/MedicalReminder/common/convert_time.dart';
import 'package:lifestyle/Reminder/MedicalReminder/global_bloc.dart';
import 'package:lifestyle/Reminder/MedicalReminder/models/errors.dart';
import 'package:lifestyle/Reminder/MedicalReminder/models/medicine.dart';
import 'package:lifestyle/Reminder/MedicalReminder/models/medicine_type.dart';
import 'package:lifestyle/Reminder/MedicalReminder/ui/new_entry/new_entry_bloc.dart';
import 'package:lifestyle/Reminder/MedicalReminder/ui/success_screen/success_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NewEntry extends StatefulWidget {
  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  TextEditingController nameController;
  TextEditingController dosageController;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  NewEntryBloc _newEntryBloc;

  GlobalKey<ScaffoldState> _scaffoldKey;

  void dispose() {
    super.dispose();
    nameController.dispose();
    dosageController.dispose();
    _newEntryBloc.dispose();
  }

  void initState() {
    super.initState();
    _newEntryBloc = NewEntryBloc();
    nameController = TextEditingController();
    dosageController = TextEditingController();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _scaffoldKey = GlobalKey<ScaffoldState>();

    initializeErrorListen();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);

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
          "Add New Reminders ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Container(
        child: Provider<NewEntryBloc>.value(
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
                title: "Medicine Name",
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
                title: "Dosage in mg",
                isRequired: false,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: dosageController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: 16,
                ),
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),

              PanelTitle(
                title: "Medicine Type",
                isRequired: false,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: StreamBuilder<MedicineType>(
                  stream: _newEntryBloc.selectedMedicineType,
                  builder: (context, snapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        MedicineTypeColumn(
                            type: MedicineType.Pill,
                            name: "Pill",
                            iconValue: 0xe901,
                            isSelected: snapshot.data == MedicineType.Pill ? true : false),
                        MedicineTypeColumn(
                            type: MedicineType.Syringe,
                            name: "Syringe",
                            iconValue: 0xe902,
                            isSelected: snapshot.data == MedicineType.Syringe ? true : false),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              PanelTitle(
                title: "Interval Selection",
                isRequired: true,
              ),
              SizedBox(
                height: 20,
              ),
              //ScheduleCheckBoxes(),
              IntervalSelection(),
              SizedBox(
                height: 20,
              ),
              PanelTitle(
                title: "Starting Time",
                isRequired: true,
              ),
              SelectTime(),
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
                        "Add Medicine",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      String medicineName;
                      int dosage;
                      //--------------------Error Checking------------------------
                      //Had to do error checking in UI
                      //Due to unoptimized BLoC value-grabbing architecture
                      if (nameController.text == "") {
                        _newEntryBloc.submitError(EntryError.NameNull);
                        return;
                      }
                      if (nameController.text != "") {
                        medicineName = nameController.text;
                      }
                      if (dosageController.text == "") {
                        dosage = 0;
                      }
                      if (dosageController.text != "") {
                        dosage = int.parse(dosageController.text);
                      }

                      // for (var medicine in _globalBloc.medicineList$.value) {
                      //   if (medicineName == medicine.medicineName) {
                      //     _newEntryBloc.submitError(EntryError.NameDuplicate);
                      //     return;
                      //   }
                      // }
                      _globalBloc.medicineList$.forEach((element) {
                        // print("el: $element");
                        element.forEach((element) {
                          // print("$medicineName = ${element.getName}");
                          if (medicineName == element.getName) {
                            _newEntryBloc.submitError(EntryError.NameDuplicate);
                            return;
                          }
                        });
                      });

                      // if (_newEntryBloc.selectedInterval$ == 0) {
                      //   _newEntryBloc.submitError(EntryError.Interval);
                      //   return;
                      // }
                      _newEntryBloc.selectedInterval$.forEach((element) {
                        // print("selectedInterval: $element");
                        if (element == 0) {
                          _newEntryBloc.submitError(EntryError.Interval);
                          return;
                        }
                      });

                      // if (_newEntryBloc.selectedTimeOfDay$.value == "None") {
                      //   _newEntryBloc.submitError(EntryError.StartTime);
                      //   return;
                      // }
                      _newEntryBloc.selectedTimeOfDay$.forEach((element) {
                        // print("selectedTimeOfDay: $element");
                        if (element == "None") {
                          _newEntryBloc.submitError(EntryError.StartTime);
                          return;
                        }
                      });

                      //---------------------------------------------------------
                      // String medicineType = _newEntryBloc.selectedMedicineType.value.toString().substring(13);
                      String medicineType;
                      _newEntryBloc.selectedMedicineType.forEach((element) {
                        medicineType = element.toString().substring(13);
                      });
                      print("selectedMedicineType: $medicineType");

                      // int interval = _newEntryBloc.selectedInterval$.value;
                      int interval;
                      _newEntryBloc.selectedInterval$.forEach((element) {
                        interval = element;
                      });

                      // String startTime = _newEntryBloc.selectedTimeOfDay$.value;
                      String startTime;
                      _newEntryBloc.selectedTimeOfDay$.forEach((element) {
                        startTime = element;
                      });
                      print("selectedTimeOfDay: $startTime");

                      // List<int> intIDs = makeIDs(24 / _newEntryBloc.selectedInterval$.value);
                      Timer(Duration(seconds: 1), () {
                        print("selectedInterval: $interval");

                        List<int> intIDs = makeIDs(24 / interval);

                        List<String> notificationIDs = intIDs.map((i) => i.toString()).toList(); //for Shared preference

                        Medicine newEntryMedicine = Medicine(
                          notificationIDs: notificationIDs,
                          medicineName: medicineName,
                          dosage: dosage,
                          medicineType: medicineType,
                          interval: interval,
                          startTime: startTime,
                        );

                        _globalBloc.updateMedicineList(newEntryMedicine);

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
            ],
          ),
        ),
      ),
    );
  }

  void initializeErrorListen() {
    _newEntryBloc.errorState$.listen(
      (EntryError error) {
        switch (error) {
          case EntryError.NameNull:
            displayError("Please enter the medicine's name");
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
          case EntryError.StartTime:
            displayError("Please select the reminder's starting time");
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
  @override
  _IntervalSelectionState createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  var _intervals = [
    6,
    8,
    10,
    12,
    24,
  ];
  var _selected = 0;

  @override
  Widget build(BuildContext context) {
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Remind me every",
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
                    value.toString(),
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

class SelectTime extends StatefulWidget {
  @override
  _SelectTimeState createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay _time = TimeOfDay(hour: 0, minute: 00);
  bool _clicked = false;
  NewEntryBloc _newEntryBloc;

  // Future<TimeOfDay> _selectTime(BuildContext context) async {
  //   final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);

  //   final TimeOfDay picked = await showTimePicker(
  //     context: context,
  //     initialTime: _time,
  //   );
  //   if (picked != null && picked != _time) {
  //     setState(() {
  //       _time = picked;
  //       _clicked = true;
  //       _newEntryBloc.updateTime("${convertTime(_time.hour.toString())}" + "${convertTime(_time.minute.toString())}");
  //     });
  //   }
  //   return picked;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    _newEntryBloc = Provider.of<NewEntryBloc>(context);

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

                                      _newEntryBloc.updateTime("${convertTime(_time.hour.toString())}" +
                                          "${convertTime(_time.minute.toString())}");
                                    });
                                  }
                                });

            
          },
          child: Center(
            child: Text(
              _clicked == false
                  ? "Pick Time"
                  : "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}",
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

class MedicineTypeColumn extends StatelessWidget {
  final MedicineType type;
  final String name;
  final int iconValue;
  final bool isSelected;

  MedicineTypeColumn(
      {Key key, @required this.type, @required this.name, @required this.iconValue, @required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
    return GestureDetector(
      onTap: () {
        _newEntryBloc.updateSelectedMedicine(type);
      },
      child: Column(
        children: <Widget>[
          /*  Container(
            width: 85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected ? Colors.blue : Colors.white,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 14.0),
                child: Icon(
                  IconData(iconValue, fontFamily: "Ic"),
                  size: 75,
                  color: isSelected ? Colors.white : Colors.blue,
                ),
              ),
            ),
          ),*/
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected ? Colors.white : Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
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
