import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifestyle/Reminder/MedicalReminder/models/birthday.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class GlobalBlocBirthday {
  BehaviorSubject<List<Birthday>> _birthdayList$;
  BehaviorSubject<List<Birthday>> get birthdayList$ => _birthdayList$;

  GlobalBlocBirthday() {
    _birthdayList$ = BehaviorSubject<List<Birthday>>.seeded([]);
    makeBirthdayList();
  }

  Future removeBirthday(Birthday tobeRemoved) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> birthdayJsonList = [];

    var blocList = _birthdayList$.value;
    blocList.removeWhere((medicine) => medicine.birthdayName == tobeRemoved.birthdayName);

    for (int i = 0; i < (24 / tobeRemoved.interval).floor(); i++) {
      flutterLocalNotificationsPlugin.cancel(int.parse(tobeRemoved.notificationIDs[i]));
    }
    if (blocList.length != 0) {
      for (var blocBirthday in blocList) {
        String medicineJson = jsonEncode(blocBirthday.toJson());
        birthdayJsonList.add(medicineJson);
      }
    }
    sharedUser.setStringList('birthdays', birthdayJsonList);
    _birthdayList$.add(blocList);
  }

  Future updateBirthdayList(Birthday newBirthday, index) async {
    var blocList = _birthdayList$.value;

    if (index != -1) {
      blocList.removeAt(index);
      blocList.insert(index, newBirthday);
    }
    else blocList.add(newBirthday);
    
    Fluttertoast.showToast(msg: "blocList: ${blocList.length}");

    _birthdayList$.add(blocList);

    Map<String, dynamic> tempMap = newBirthday.toJson();
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    String newBirthdayJson = jsonEncode(tempMap);
    List<String> birthdayJsonList = [];
    if (sharedUser.getStringList('birthdays') == null) {
      birthdayJsonList.add(newBirthdayJson);
    } else {
      birthdayJsonList = sharedUser.getStringList('birthdays');
      birthdayJsonList.add(newBirthdayJson);
    }

    sharedUser.setStringList('birthdays', birthdayJsonList);
  }

  Future makeBirthdayList() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> jsonList = sharedUser.getStringList('birthdays');
    List<Birthday> prefList = [];
    if (jsonList == null) {
      return;
    } else {
      for (String jsonBirthday in jsonList) {
        Map userMap = jsonDecode(jsonBirthday);
        Birthday tempBirthday = Birthday.fromJson(userMap);
        prefList.add(tempBirthday);
      }
      _birthdayList$.add(prefList);
    }
  }

  void dispose() {
    _birthdayList$.close();
  }
}
