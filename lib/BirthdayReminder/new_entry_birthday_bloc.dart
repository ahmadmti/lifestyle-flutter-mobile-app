import 'package:lifestyle/Reminder/MedicalReminder/models/errors.dart';
import 'package:lifestyle/Reminder/MedicalReminder/models/medicine_type.dart';
import 'package:rxdart/rxdart.dart';

class NewEntryBirthdayBloc {

  BehaviorSubject<int> _selectedInterval$;
  BehaviorSubject<int> get selectedInterval$ => _selectedInterval$;

  BehaviorSubject<String> _selectedDate$;
  BehaviorSubject<String> get selectedDate$ => _selectedDate$;
  
  BehaviorSubject<String> _selectedTimeOfDay$;
  BehaviorSubject<String> get selectedTimeOfDay$ => _selectedTimeOfDay$;

  BehaviorSubject<EntryError> _errorState$;
  BehaviorSubject<EntryError> get errorState$ => _errorState$;

  NewEntryBirthdayBloc() {

    _selectedTimeOfDay$ = BehaviorSubject<String>.seeded("None");
    _selectedDate$ = BehaviorSubject<String>.seeded("None");
    _selectedInterval$ = BehaviorSubject<int>.seeded(0);
    _errorState$ = BehaviorSubject<EntryError>();
  }

  void dispose() {

    _selectedDate$.close();
    _selectedTimeOfDay$.close();
    _selectedInterval$.close();
  }

  void submitError(EntryError error) {
    _errorState$.add(error);
  }

  void updateInterval(int interval) {
    _selectedInterval$.add(interval);
  }

  void updateDate(String date) {
    print("date: $date");
    _selectedDate$.add(date);
  }
  
  void updateTime(String time) {
    print("time: $time");
    _selectedTimeOfDay$.add(time);
  }

  
}
