import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/configs/app_configs.dart';

class AppDateUtil {
  AppDateUtil._();

  static String toDateString(DateTime dateTime) {
    return DateFormat(AppConfigs.dateDisplayFormat).format(dateTime);
  }

  static String toDateTodayString(DateTime dateTime) {
    String format = AppConfigs.dateTimeDisplayFormat;
    if (dateTime.day == DateTime.now().day &&
        dateTime.month == DateTime.now().month &&
        dateTime.year == DateTime.now().year) {
      format = AppConfigs.timeDisplayFormat;
    }
    return DateFormat(format).format(dateTime);
  }

  static String toDatePickerString(DateTime dateTime) {
    return DateFormat(AppConfigs.datePickerFormat).format(dateTime);
  }

  static String toTimePickerString(DateTime dateTime) {
    return DateFormat(AppConfigs.timeDisplayFormat).format(dateTime);
  }

  static DateTime? fromDateString(String date, {String? format}) {
    if (format != null) {
      try {
        return DateFormat(format).parse(date);
      } catch (e) {
        log(e.toString());
      }
    }
    try {
      return DateFormat(AppConfigs.datePickerFormat).parse(date);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static String timeOfDayToString(TimeOfDay time, {String? format}) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat(format ?? AppConfigs.timeDisplayFormat).format(dt);
  }

  static TimeOfDay formTimeString(String timeStr, {String? format}) {
    final dt = DateFormat(format ?? AppConfigs.timeDisplayFormat).parse(timeStr);
    return TimeOfDay(hour: dt.hour, minute: dt.minute);
  }

}
