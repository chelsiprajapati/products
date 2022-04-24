import 'package:intl/intl.dart';

class DateFormatUtils {
  static DateFormat dateFormat = DateFormat("dd, MMM yyyy");

  static String formattedDate(DateTime date) => dateFormat.format(date);
  static DateTime getDate(String date) => dateFormat.parse(date);
}
