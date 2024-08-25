import 'package:intl/intl.dart';

import '../../resources/text/app_titles.dart';

extension DateTimeExtension on DateTime {
  DateTime get firstDayOfMonth => DateTime(year, month);

  DateTime get firstDayOfPreviousMonth =>
      month == DateTime.january ? DateTime(year - 1, 12) : DateTime(year, month - 1);

  DateTime get firstDayOfNextMonth =>
      month == DateTime.december ? DateTime(year + 1) : DateTime(year, month + 1);

  int get daysInMonth => firstDayOfNextMonth.difference(firstDayOfMonth).inDays;

  int get rangeCalendarWeekday => weekday % 7 + 1;

  String get monthName => _kMonthNames[month - 1];

  String get formattedMonth => '$monthName $year';

  DateTime getDateFromDayInMonth(int value) => DateTime(year, month, value);

  bool isSameDateAs(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  bool isAfterOrSameDateAs(DateTime other) => isSameDateAs(other) || isAfter(other);

  bool isInDateInterval(DateTime first, DateTime second) =>
      (isAfter(first) && isBefore(second)) || isSameDateAs(first) || isSameDateAs(second);

  String formattedIntervalTil(DateTime other) {
    final formatter = DateFormat('dd.MM.yyyy');
    return '${formatter.format(this)} - ${formatter.format(other)}';
  }
}

const List<String> _kMonthNames = [
  AppTitles.january,
  AppTitles.february,
  AppTitles.march,
  AppTitles.april,
  AppTitles.may,
  AppTitles.june,
  AppTitles.july,
  AppTitles.august,
  AppTitles.september,
  AppTitles.october,
  AppTitles.november,
  AppTitles.december,
];
