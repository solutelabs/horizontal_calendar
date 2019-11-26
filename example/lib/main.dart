import 'package:flutter/material.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Horizontal Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: HorizontalCalendar(
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 30)),
            dateFormat: 'dd',
            dayFormat: 'EE',
            monthFormat: null,
            selectedDecoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            disabledDecoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
            dateTextStyle: Theme.of(context).textTheme.title.copyWith(
                  color: Colors.black,
                  fontSize: 26,
                ),
            selectedDateTextStyle: Theme.of(context).textTheme.title.copyWith(
                  color: Colors.white,
                  fontSize: 26,
                ),
            isDateDisabled: (date) => date.weekday == 7,
          ),
        ),
      ),
    );
  }
}
