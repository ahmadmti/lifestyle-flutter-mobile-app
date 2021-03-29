import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lifestyle/BirthdayReminder/birthday_reminder_bloc.dart';
import 'package:lifestyle/Reminder/MedicalReminder/models/birthday.dart';
import 'package:lifestyle/Reminder/MedicalReminder/models/medicine.dart';
import 'package:provider/provider.dart';

class BirthdayDetails extends StatelessWidget {
  final Birthday birthday;

  BirthdayDetails(this.birthday);

  @override
  Widget build(BuildContext context) {
    final GlobalBlocBirthday _globalBloc = Provider.of<GlobalBlocBirthday>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          "Reminder Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MainSection(birthday: birthday),
              SizedBox(
                height: 15,
              ),
              ExtendedSection(birthday: birthday),
            ],
          ),
        ),
      ),
    );
  }
}

class MainSection extends StatelessWidget {
  final Birthday birthday;

  MainSection({
    Key key,
    @required this.birthday,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          //   makeIcon(175),
          SizedBox(
            width: 15,
          ),
          Column(
            children: <Widget>[
              Hero(
                tag: birthday.birthdayName,
                child: Material(
                  color: Colors.transparent,
                  child: MainInfoTab(
                    fieldTitle: "Birthday Name",
                    fieldInfo: birthday.birthdayName??'',
                  ),
                ),
              ),

              // MainInfoTab(
              //   fieldTitle: "Note",
              //   fieldInfo: birthday.birthdayNote,
              // )
            ],
          )
        ],
      ),
    );
  }
}

class MainInfoTab extends StatelessWidget {
  final String fieldTitle;
  final String fieldInfo;

  MainInfoTab({Key key, @required this.fieldTitle, @required this.fieldInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      height: 100,
      child: ListView(
        padding: EdgeInsets.only(top: 15),
        shrinkWrap: true,
        children: <Widget>[
          Text(
            fieldTitle,
            style: TextStyle(fontSize: 17, color: Color(0xFFC9C9C9), fontWeight: FontWeight.bold),
          ),
          Text(
            fieldInfo,
            style: TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class ExtendedSection extends StatelessWidget {
  final Birthday birthday;

  ExtendedSection({Key key, @required this.birthday}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ExtendedInfoTab(
            fieldTitle: "Note",
            fieldInfo: birthday.birthdayNote??'',
          ),
          ExtendedInfoTab(
            fieldTitle: "Time",
            fieldInfo: birthday.date.toString() +
                " - " +
                birthday.time.toString().substring(0, 2) +
                ":" +
                birthday.time.toString().substring(2, 4),
          ),
          ExtendedInfoTab(
            fieldTitle: "Interval",
            fieldInfo: birthday.interval.toString() + " hours before",
          ),
        ],
      ),
    );
  }
}

class ExtendedInfoTab extends StatelessWidget {
  final String fieldTitle;
  final String fieldInfo;

  ExtendedInfoTab({Key key, @required this.fieldTitle, @required this.fieldInfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                fieldTitle,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              fieldInfo,
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFC9C9C9),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
