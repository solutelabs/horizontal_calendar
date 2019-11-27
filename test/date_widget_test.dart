import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizontal_calendar/date_widget.dart';

void main() {
  testWidgets(
      'Render widgets with date / month/ weekday by default formats if formats are provided not explicitly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        child: DateWidget(
          date: DateTime(2019, 11, 17),
          padding: EdgeInsets.all(8),
        ),
        textDirection: TextDirection.ltr,
      ),
    );

    final date17 = find.text('17');
    expect(date17, findsOneWidget);
    final month11 = find.text('Nov');
    expect(month11, findsOneWidget);
    final week17 = find.text('Sun');
    expect(week17, findsOneWidget);
  });

  testWidgets(
    'Render widgets with dates / month / week day by default formats if formats are provided explicitly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          child: DateWidget(
            date: DateTime(2019, 11, 17),
            padding: EdgeInsets.all(8),
            dateFormat: 'dd/MMM',
            monthFormat: 'MM',
            weekDayFormat: 'EEEE',
          ),
          textDirection: TextDirection.ltr,
        ),
      );

      final month11 = find.text('11');
      expect(month11, findsOneWidget);
      final date17 = find.text('17/Nov');
      expect(date17, findsOneWidget);
      final week17 = find.text('Sunday');
      expect(week17, findsOneWidget);
    },
  );

  testWidgets(
    'Month / weekday should not render if pattern is NULL',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          child: DateWidget(
            date: DateTime(2019, 11, 17),
            padding: EdgeInsets.all(8),
            dateFormat: 'dd/MMM',
            monthFormat: null,
            weekDayFormat: null,
          ),
          textDirection: TextDirection.ltr,
        ),
      );

      final month11 = find.text('11');
      expect(month11, findsNothing);
      final date17 = find.text('17/Nov');
      expect(date17, findsOneWidget);
      final week17 = find.text('Sunday');
      expect(week17, findsNothing);
    },
  );

  testWidgets(
    'date should always render even if pattern is NULL',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          child: DateWidget(
            date: DateTime(2019, 11, 17),
            padding: EdgeInsets.all(8),
            dateFormat: null,
            monthFormat: null,
            weekDayFormat: null,
          ),
          textDirection: TextDirection.ltr,
        ),
      );

      final month11 = find.text('11');
      expect(month11, findsNothing);
      final date17 = find.text('17');
      expect(date17, findsOneWidget);
      final week17 = find.text('Sunday');
      expect(week17, findsNothing);
    },
  );

  testWidgets(
    'Default decoration should be applied to Date / month / weekday if not selected',
    (WidgetTester tester) async {
      final dateDecoration = BoxDecoration(
        color: Colors.blue,
      );

      await tester.pumpWidget(
        Directionality(
          child: DateWidget(
            date: DateTime(2019, 11, 17),
            padding: EdgeInsets.all(8),
            dateFormat: null,
            monthFormat: null,
            weekDayFormat: null,
            defaultDecoration: dateDecoration,
          ),
          textDirection: TextDirection.ltr,
        ),
      );

      WidgetPredicate datePredicate = (Widget widget) =>
          widget is Container && widget.decoration == dateDecoration;
      expect(find.byWidgetPredicate(datePredicate), findsOneWidget);
    },
  );

  testWidgets(
    'Selected decoration should be applied to Date / month / weekday is selected',
    (WidgetTester tester) async {
      final dateDecoration = BoxDecoration(
        color: Colors.blue,
      );

      await tester.pumpWidget(
        Directionality(
          child: DateWidget(
            date: DateTime(2019, 11, 17),
            padding: EdgeInsets.all(8),
            dateFormat: null,
            monthFormat: null,
            weekDayFormat: null,
            selectedDecoration: dateDecoration,
            isSelected: true,
          ),
          textDirection: TextDirection.ltr,
        ),
      );

      WidgetPredicate datePredicate = (Widget widget) =>
          widget is Container && widget.decoration == dateDecoration;
      expect(find.byWidgetPredicate(datePredicate), findsOneWidget);
    },
  );

  testWidgets(
    'Disabled decoration should be applied to Date / month / weekday if is disabled',
    (WidgetTester tester) async {
      final dateDecoration = BoxDecoration(
        color: Colors.blue,
      );

      final style = TextStyle(color: Colors.white);

      await tester.pumpWidget(
        Directionality(
          child: DateWidget(
            date: DateTime(2019, 11, 17),
            padding: EdgeInsets.all(8),
            dateFormat: null,
            monthFormat: null,
            weekDayFormat: null,
            disabledDecoration: dateDecoration,
            isDisabled: true,
            dateTextStyle: style,
          ),
          textDirection: TextDirection.ltr,
        ),
      );

      WidgetPredicate datePredicate = (Widget widget) =>
          widget is Container && widget.decoration == dateDecoration;
      expect(find.byWidgetPredicate(datePredicate), findsOneWidget);

      WidgetPredicate dateTextStyle =
          (Widget widget) => widget is Text && widget.style == style;
      expect(find.byWidgetPredicate(dateTextStyle), findsOneWidget);
    },
  );

  testWidgets(
    'Default Date with all properties',
    (WidgetTester tester) async {
      final defaultDecoration = BoxDecoration(
        color: Colors.blue,
      );

      final padding = EdgeInsets.symmetric(horizontal: 8);

      final monthStyle = TextStyle(color: Colors.white);
      final monthFormat = 'MM';

      final dateStyle = TextStyle(color: Colors.black);
      final dateFormat = 'dd/MM';

      final weekDayStyle = TextStyle(color: Colors.green);
      final weekDayFormat = 'EEE';

      await tester.pumpWidget(
        Directionality(
          child: DateWidget(
            date: DateTime(2019, 11, 17),
            padding: padding,
            dateFormat: dateFormat,
            dateTextStyle: dateStyle,
            monthFormat: monthFormat,
            monthTextStyle: monthStyle,
            weekDayFormat: weekDayFormat,
            weekDayTextStyle: weekDayStyle,
            defaultDecoration: defaultDecoration,
          ),
          textDirection: TextDirection.ltr,
        ),
      );

      WidgetPredicate datePredicate = (Widget widget) =>
          widget is Container && widget.decoration == defaultDecoration;
      expect(find.byWidgetPredicate(datePredicate), findsOneWidget);

      WidgetPredicate dateTextStyle = (Widget widget) =>
          widget is Text && widget.style == dateStyle && widget.data == '17/11';
      expect(find.byWidgetPredicate(dateTextStyle), findsOneWidget);

      WidgetPredicate monthTextStyle = (Widget widget) =>
          widget is Text && widget.style == monthStyle && widget.data == '11';
      expect(find.byWidgetPredicate(monthTextStyle), findsOneWidget);

      WidgetPredicate weekDayTextStyle = (Widget widget) =>
          widget is Text &&
          widget.style == weekDayStyle &&
          widget.data == 'Sun';
      expect(find.byWidgetPredicate(weekDayTextStyle), findsOneWidget);
    },
  );
}
