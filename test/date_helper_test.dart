import 'package:flutter_test/flutter_test.dart';
import 'package:horizontal_calendar/date_helper.dart';

void main() {
  test(
      'Returned date should have only year,month,date and other components as zero',
      () {
    final actualDate = DateTime.now();
    final date = toDateMonthYear(actualDate);
    expect(date.year, actualDate.year);
    expect(date.month, actualDate.month);
    expect(date.day, actualDate.day);
    expect(date.hour, 0);
    expect(date.minute, 0);
  });

  test('Return date lists of in between days', () {
    final expected = [
      _toDateMonthYear(DateTime.now()),
      _toDateMonthYear(DateTime.now().add(Duration(days: 1))),
    ];
    final list = getDateList(DateTime.now(), DateTime.now().add(Duration(days: 1)));
    expect(list, expected);
  });

  test('Return single day, if from and to date are same', () {
    final expected = [_toDateMonthYear(DateTime.now())];
    final list = getDateList(DateTime.now(), DateTime.now());
    expect(list, expected);
  });
}

DateTime _toDateMonthYear(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}
