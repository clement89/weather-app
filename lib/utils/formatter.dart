import 'package:intl/intl.dart';

class Formatter {
  static String formatDate(String dateString) {
    final outputFormat = DateFormat.MMMEd();

    try {
      final parsedDate = DateTime.parse(dateString);
      return outputFormat.format(parsedDate);
    } catch (e) {
      // Handle date parsing error, return the original string if needed
      return dateString;
    }
  }

  static String formatTime(String dateString) {
    final outputFormat = DateFormat.Hm();

    try {
      final parsedDate = DateTime.parse(dateString);
      return outputFormat.format(parsedDate);
    } catch (e) {
      // Handle date parsing error, return the original string if needed
      return dateString;
    }
  }

  static String formatDateApi(String dateString) {
    final outputFormat = DateFormat('yyyy-MM-dd');
    try {
      final parsedDate = DateTime.parse(dateString);
      return outputFormat.format(parsedDate);
    } catch (e) {
      // Handle date parsing error, return the original string if needed
      return dateString;
    }
  }
}
