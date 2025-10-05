import 'package:intl/intl.dart';

class TimeUtil {
  /// 将 Unix 时间戳（秒 或 毫秒）转换为北京时间字符串
  static String formatTimestamp(
    int timestamp, {
    String pattern = 'yyyy-MM-dd HH:mm:ss',
  }) {
    try {
      // 判断是秒还是毫秒级时间戳
      if (timestamp < 10000000000) {
        timestamp *= 1000; // 如果是秒，转成毫秒
      }

      // 转换为 UTC 时间后 +8小时变为北京时间
      final dateTime = DateTime.fromMillisecondsSinceEpoch(
        timestamp,
        isUtc: true,
      ).add(const Duration(hours: 8));

      // 使用 intl 格式化
      final formatter = DateFormat(pattern);
      return formatter.format(dateTime);
    } catch (e) {
      return 'Invalid Time';
    }
  }

  /// 获取当前时间（北京时间）
  static DateTime nowBeijing() {
    return DateTime.now().toUtc().add(const Duration(hours: 8));
  }

  /// 将 DateTime 转换为北京时间字符串
  static String formatDateTime(
    DateTime dateTime, {
    String pattern = 'yyyy-MM-dd HH:mm:ss',
  }) {
    final formatter = DateFormat(pattern);
    return formatter.format(dateTime.toUtc().add(const Duration(hours: 8)));
  }
}
