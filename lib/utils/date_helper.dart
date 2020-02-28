import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static DateTime getDateTime(String formattedDate, String format) {
    var formatter = new DateFormat(format);
    DateTime dateTime = formatter.parse(formattedDate);
    return dateTime;
  }

  static TimeOfDay getTimeOfDayFrom24HourFormat(String time) {
    TimeOfDay timeOfDay = TimeOfDay(
        hour: int.parse(time.split(":")[0]),
        minute: int.parse(time.split(":")[1]));
    return timeOfDay;
  }

  static TimeOfDay getTimeOfDay(String time, String format) {
    final date = getDateTime(time, format);
    TimeOfDay timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
    return timeOfDay;
  }

  static String getFormatedTimeIn12Hour(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return getFormattedDate(dateTime, 'hh:mm a');
  }

  static String getDateString(
      String date, String inputFormat, String outputFormat, bool isInputUtc) {
    var inputFormatter = new DateFormat(inputFormat);
    DateTime dateTime = inputFormatter.parse(date);
    dateTime.add(Duration(hours: 5, minutes: 30)); // UTC to local time
    var outputFormatter = new DateFormat(outputFormat);
    return outputFormatter.format(dateTime);
  }

  static String getFormattedDate(DateTime dateTime, String format) {
    var formatter = new DateFormat(format);
    return formatter.format(dateTime);
  }

  static void openDatePicker({
    @required BuildContext context,
    DateTime initialDate,
    DateTime firstDate,
    @required DateTime lastDate,
    @required Function(DateTime) onDateSelect,
  }) async {
    DateTime dateTime = await showDatePicker(
        context: context,
        initialDate: initialDate == null ? DateTime.now() : initialDate,
        firstDate: firstDate == null ? DateTime(1970) : firstDate,
        lastDate: lastDate);
    onDateSelect(dateTime);
  }

  static void openTimePicker(
      {@required BuildContext context,
      @required Function(TimeOfDay) onTimeSelected}) async {
    TimeOfDay timeOfDay =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    onTimeSelected(timeOfDay);
  }

  static void openDateTimePicker({
    @required BuildContext context,
    DateTime initialDate,
    DateTime firstDate,
    @required DateTime lastDate,
    @required Function(DateTime) onDateSelect,
  }) async {
    DateTime dateTime = await showDatePicker(
        context: context,
        initialDate: initialDate == null ? DateTime.now() : initialDate,
        firstDate: firstDate == null ? DateTime(1970) : firstDate,
        lastDate: lastDate);
    TimeOfDay timeOfDay =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    DateTime newDateTime = DateTime(dateTime.year, dateTime.month, dateTime.day,
        timeOfDay.hour, timeOfDay.minute);
    onDateSelect(newDateTime);
  }
}
