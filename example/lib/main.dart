import 'package:flutter/material.dart';
import 'package:horizontal_calendar/date_helper.dart';
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
      home: new NewWidget(),
    );
  }
}

class NewWidget extends StatefulWidget {
  const NewWidget({
    Key key,
  }) : super(key: key);

  @override
  _NewWidgetState createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          HorizontalCalendar(
            height: 100,
            padding: EdgeInsets.all(16),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 30)),
            dateFormat: 'dd',
            weekDayFormat: 'EE',
            monthFormat: 'MMMM',
            selectedDecoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            disabledDecoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
            initialSelectedDates: [DateTime(2019, 11, 28)],
            isDateDisabled: (date) => date.weekday == 7,
            labelOrder: [
              LabelType.date,
              LabelType.weekday,
            ],
          ),
          RaisedButton(onPressed: () {
            setState(() {});
          })
        ],
      ),
    );
  }
}
