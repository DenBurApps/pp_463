import 'package:intl/intl.dart';

class DateHelper {
  static String formatDate(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();
    return '$day.$month.$year';
  }

  static String formatTime(DateTime time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static String formatDateChildCard(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd.MM.yy');
    String formattedDate = formatter.format(dateTime);

    DateTime now = DateTime.now();

    bool isToday = now.year == dateTime.year &&
        now.month == dateTime.month &&
        now.day == dateTime.day;

    return isToday ? 'Today, $formattedDate' : formattedDate;
  }

  static String formatInTextDate(DateTime date) {
    const List<String> months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    int day = date.day;
    String month = months[date.month - 1];
    int year = date.year;

    return '$day $month, $year';
  }


  static String formatInDayMonth(DateTime date) {
    const List<String> months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    int day = date.day;
    String month = months[date.month - 1];

    return '$month, $day';
  }
}