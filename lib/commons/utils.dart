import 'package:intl/intl.dart';

class Utils {
  /* ISO8601 타입의 시간을 파싱 */
  static String getDuration(String duration) {
    if (duration.isEmpty) return null;
    duration = duration.replaceFirst("PT", "");

    var validDuration = ["H", "M", "S"];
    if (!duration.contains(new RegExp(r'[HMS]'))) {
      return null;
    }
    var hour = 0, min = 0, sec = 0;
    for (int i = 0; i < validDuration.length; i++) {
      var index = duration.indexOf(validDuration[i]);
      if (index != -1) {
        var valInString = duration.substring(0, index);
        var val = int.parse(valInString);
        if (i == 0)
          hour = val;
        else if (i == 1)
          min = val;
        else if (i == 2) sec = val;
        duration = duration.substring(valInString.length + 1);
      }
    }
    List buff = [];
    if (hour != 0) {
      buff.add(hour.toString());
    }
    if (min < 10) {
      if (hour != 0)
        buff.add(min.toString().padLeft(2, '0'));
      else
        buff.add(min.toString());
    } else {
      buff.add(min.toString().padLeft(2, '0'));
    }
    buff.add(sec.toString().padLeft(2, '0'));

    return buff.join(":");
  }

  static String numberGrouping(int viewCount) {
    return NumberFormat('###,###,###,###').format(viewCount).replaceAll(' ', '');
  }

  static String replaceTitle(String title) {
    return title.replaceAll(RegExp('&quot;'), " ");
  }
}
