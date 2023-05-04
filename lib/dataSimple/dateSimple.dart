import 'dart:convert';

class DateTimeLove {
  late int year;
  late int month;
  late int week;
  late int day;

  DateTimeLove(
      {required this.year,
      required this.month,
      required this.week,
      required this.day});
}

class InfoPrimary {
  final int ageMe;
  final int ageGirlfriend;
  final String notificationContent;
  final DateTimeLove timeLove;
  final String fromDate;
  final String currentDate;

  const InfoPrimary({
    required this.ageMe,
    required this.ageGirlfriend,
    required this.notificationContent,
    required this.timeLove,
    required this.fromDate,
    required this.currentDate,
  });

  factory InfoPrimary.fromJson(Map<String, dynamic> jsonResult) {
    return InfoPrimary(
      ageMe: jsonResult['ageMe'],
      ageGirlfriend: jsonResult['ageGirlfriend'],
      notificationContent: jsonResult['notificationContent'],
      timeLove: DateTimeLove(
        year: jsonResult['timeLove']['year'],
        month: jsonResult['timeLove']['month'],
        week: jsonResult['timeLove']['week'],
        day: jsonResult['timeLove']['day'],
      ),
      fromDate: jsonResult['fromDate'],
      currentDate: jsonResult['currentDate'],
    );
  }
}
