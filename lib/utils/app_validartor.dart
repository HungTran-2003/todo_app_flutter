import 'dart:developer';

import 'package:todo_app/utils/app_date_util.dart';

class AppValidator {
  AppValidator._();

  static String? validateEmpty(String? input) {
    if (input == null || input.isEmpty) {
      return "cannot be left blank";
    }
    return null;
  }

  static String? validateTime(String? dateText, String? timeText){
    if(validateEmpty(dateText) == null && validateEmpty(timeText) == null){
      final now = DateTime.now();
      final date = AppDateUtil.fromDateString(dateText!);
      final text = AppDateUtil.formTimeString(timeText!);
      try{
        final dateTime = DateTime(date!.year, date.month, date.day, text.hour, text.minute);
        if(dateTime.isBefore(now)){
          return "cannot be in the past";
        }
      } catch(e){
        log(e.toString());
      }
    }
    return null;
  }
}