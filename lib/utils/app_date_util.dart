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
}
