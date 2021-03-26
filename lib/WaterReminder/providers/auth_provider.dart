import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// models
import '../models/app_user.dart';

//utils
import '../utils/notification_utils.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  
  User get user => _firebaseAuth.currentUser;

  Future<bool> selectGoogleAcount() async {
    try {

      QuerySnapshot querySnapshot = await _firestore.collection('users').where('uid',isEqualTo: _firebaseAuth.currentUser.uid).get();
      List<QueryDocumentSnapshot> docs = querySnapshot.docs;
      if(docs.length==0){
        return true;
      }
      QueryDocumentSnapshot userDoc = docs[0];
      Map<String,dynamic> data = userDoc.data();
      TimeOfDay wakeUpTime = TimeOfDay(
        hour: data['wake_up_time']['hour'],
        minute: data['wake_up_time']['minute']
      );
      await setDailyStartNotification(wakeUpTime,data['name']);
      return false;
    }catch(e){
      print(e);
      return true;
    }
  }



  Future<void> signUp(String gender,DateTime birthday,double weight,TimeOfDay time,int water) async {
    try{

      User user = _firebaseAuth.currentUser;
      DocumentReference userRef = _firestore.collection('users').doc(user.uid);
      await userRef.set(AppUser(
        uid: user.uid,
        email: user.email,
        name: user.displayName,
        gender: gender,
        birthday: birthday,
        weight: weight,
        wakeUpTime: time,
        dailyTarget: water
      ).toDoc());
      await setDailyStartNotification(time,user.displayName);
      notifyListeners();
    }catch(e){
      print(e);
    }
  }



  void signOut() async {
    await cancelAllNotifications();
    await _firebaseAuth.signOut();
    notifyListeners();
  }
}