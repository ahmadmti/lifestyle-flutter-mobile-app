class Birthday {
  final List<dynamic> notificationIDs;
  final String birthdayName;
  final String birthdayNote;
  final int interval;
  final String time;
  final String date;

  Birthday({
    this.notificationIDs,
    this.birthdayName,
    this.date,
    this.birthdayNote,
    this.time,
    this.interval,
  });

  String get getName => birthdayName;
  String get getNote => birthdayNote;
  int get getInterval => interval;
  String get getTime => time;
  String get getDate => date;
  List<dynamic> get getIDs => notificationIDs;

  Map<String, dynamic> toJson() {
    return {
      "ids": this.notificationIDs,
      "name": this.birthdayName,
      "note": this.birthdayNote,
      "interval": this.interval,
      "time": this.time,
      "date": this.date,
    };
  }

  factory Birthday.fromJson(Map<String, dynamic> parsedJson) {
    return Birthday(
      notificationIDs: parsedJson['ids'],
      birthdayName: parsedJson['name'],
      birthdayNote: parsedJson['type'],
      interval: parsedJson['interval'],
      time: parsedJson['time'],
      date: parsedJson['date'],
    );
  }
}
