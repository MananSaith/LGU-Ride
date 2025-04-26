import 'package:jiffy/jiffy.dart';

class DateFormatter {
  static dateFormatter(DateTime dateTime) {
    if (DateTime.now().difference(dateTime).inDays > 2) {
      return Jiffy.parseFromList([dateTime.year, dateTime.month, dateTime.day]).yMMMMd;
    } else {
      return Jiffy.parse("${dateTime.year}/${dateTime.month}/${dateTime.day}",
            pattern:  "yyyy/MM/dd")
          .add(
        minutes: dateTime.minute,
        hours: dateTime.hour,)
          .fromNow();
    }
  }
}
