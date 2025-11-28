import 'package:flutter/material.dart';

class AppDatePicker {
  static final _now = DateTime.now();
  static final _firstDateDefault = DateTime(
    _now.year - 100,
    _now.month,
    _now.day,
  );
  static final _lastDateDefault = DateTime(
    _now.year + 100,
    _now.month,
    _now.day,
  );
  static final _timeNow = TimeOfDay(hour: _now.hour, minute: _now.minute);

  static Future<DateTime?> pickDate(
    BuildContext context, {
    DateTime? initialDate,
  }) async {
    final DateTime? picker = await showDatePicker(
      context: context,
      firstDate: _firstDateDefault,
      lastDate: _lastDateDefault,
      currentDate: _now,
      initialDate: initialDate,
    );
    return picker;
  }

  static Future<TimeOfDay?> pickTime(
    BuildContext context, {
    TimeOfDay? initialTime,
  }) async {
    final TimeOfDay? picker = await showTimePicker(
      context: context,
      initialTime: initialTime ?? _timeNow,
    );
    return picker;
  }
}
