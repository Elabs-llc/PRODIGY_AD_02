import 'package:intl/intl.dart';

class Helper {
  static String getDate() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  }
}
