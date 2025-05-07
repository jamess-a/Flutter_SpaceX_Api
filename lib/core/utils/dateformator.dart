import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String formatDateTime(DateTime dateTime) {
    return DateFormat.yMMMMd().add_jm().format(dateTime);
  }

  static String formatShortDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static String formatWithWeekday(DateTime dateTime) {
    return DateFormat('EEEE, dd MMM yyyy').format(dateTime);
  }
}
