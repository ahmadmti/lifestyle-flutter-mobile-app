import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifestyle/Health/DietPlan/models/CategoryData.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'DimensionUtils.dart';

class CommonUtils {
  static final String COMMON_FAILED = "Failed", COMMON_SUCCESS = "Success";

  static final String MEDIA_TYPE_IMAGE = "image", MEDIA_TYPE_VIDEO = "video";

  static List<String> alMembers = new List();

  static String getSimpleDateFormatServer(DateTime dtime) {
    String formattedDate = DateFormat('dd-MMM-yyyy').format(dtime);
    return formattedDate;
  }

  static String getSimpleMonthFormatServer(DateTime dtime) {
    String formattedDate = DateFormat('MMM').format(dtime);
    return formattedDate;
  }

  static ProgressDialog getProgressDialog(context) {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
//    ProgressDialog pr = new ProgressDialog(context);
    return pr;
  }

  static void showProgressBar(ProgressDialog pr) {
    if (pr != null) {
      pr.show();
    }
  }

  static void hideProgressBar(ProgressDialog pr) {
    Future.delayed(Duration(seconds: 0)).then((onValue) {
      if (pr != null && pr.isShowing()) {
        pr.hide();
      }
    });
  }

  static showToast(var message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
//        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: DimensionUtils.txt_size_medium);
  }

  static showSuccessToast(var message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
//        timeInSecForIos: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: DimensionUtils.txt_size_medium);
  }

  static showErrorToast(var message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
//        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: DimensionUtils.txt_size_medium);
  }

  static showRequestErrorToast(int statusCode, String responseBody) {
    Fluttertoast.showToast(
        msg: getReposeStatusText(statusCode),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
//        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: DimensionUtils.txt_size_medium);
  }

  static String getGenderText(int genderId) {
    if (genderId == 1) {
      return "Male";
    } else if (genderId == 2) {
      return "Female";
    } else if (genderId == 3) {
      return "Others";
    } else {
      return "Others";
    }
  }

  static bool isValidMobile(String strMobile) {
    bool isValid = false;
    if (strMobile.length >= 7 && strMobile.length <= 13) {
      isValid = true;
    }

    return isValid;
  }

  static String getReposeStatusText(int statusCode) {
    if (statusCode == 400) {
      return "Bad Request";
    } else if (statusCode == 401) {
      return "Unauthorised Access";
    } else if (statusCode == 403) {
      return "Access Forbidden";
    } else if (statusCode == 500) {
      return "Internal Server Error";
    } else if (statusCode == 404) {
      return "Failed";
    }
  }
}
