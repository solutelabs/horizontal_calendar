import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';

void main() {
  testWidgets(
    'Assert should fail if firstDate is NULL',
    (WidgetTester tester) async {
      expectLater(
          () => tester.pumpWidget(
                Directionality(
                  child: HorizontalCalendar(
                    firstDate: null,
                    lastDate: DateTime(2019, 11, 20),
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ),
          throwsAssertionError);
    },
  );

  testWidgets(
    'Assert should fail if lastDate is NULL',
    (WidgetTester tester) async {
      expectLater(
          () => tester.pumpWidget(
                Directionality(
                  child: HorizontalCalendar(
                    firstDate: DateTime(2019, 11, 20),
                    lastDate: null,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ),
          throwsAssertionError);
    },
  );

  testWidgets(
    'Assert should fail if Label order is NULL',
        (WidgetTester tester) async {
      expectLater(
              () => tester.pumpWidget(
            Directionality(
              child: HorizontalCalendar(
                firstDate: DateTime(2019, 11, 20),
                lastDate: null,
                labelOrder: null,
              ),
              textDirection: TextDirection.ltr,
            ),
          ),
          throwsAssertionError);
    },
  );

  testWidgets(
    'Assert should fail if Label order is empty',
        (WidgetTester tester) async {
      expectLater(
              () => tester.pumpWidget(
            Directionality(
              child: HorizontalCalendar(
                firstDate: DateTime(2019, 11, 20),
                lastDate: null,
                labelOrder: [],
              ),
              textDirection: TextDirection.ltr,
            ),
          ),
          throwsAssertionError);
    },
  );

  testWidgets('Should render N widgets as provided start & end date',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        child: HorizontalCalendar(
          firstDate: DateTime(2019, 11, 17),
          lastDate: DateTime(2019, 11, 20),
          monthFormat: 'MMM',
          weekDayFormat: 'EEE',
        ),
        textDirection: TextDirection.ltr,
      ),
    );

    final month11 = find.text('Nov');
    expect(month11, findsNWidgets(4));

    final date17 = find.text('17');
    expect(date17, findsOneWidget);
    final week17 = find.text('Sun');
    expect(week17, findsOneWidget);

    final date18 = find.text('18');
    expect(date18, findsOneWidget);
    final week18 = find.text('Mon');
    expect(week18, findsOneWidget);

    final date19 = find.text('19');
    expect(date19, findsOneWidget);
    final week19 = find.text('Tue');
    expect(week19, findsOneWidget);
  });

  testWidgets(
    'Default / Selected / Disabled widgets should render as per arguments',
    (WidgetTester tester) async {
      final dateDecoration = BoxDecoration(
        color: Colors.blue,
      );
      final selectedDateDecoration = BoxDecoration(
        color: Colors.green,
      );

      final disabledDateDecoration = BoxDecoration(
        color: Colors.grey,
      );

      await tester.pumpWidget(
        Directionality(
          child: HorizontalCalendar(
            firstDate: DateTime(2019, 11, 17),
            lastDate: DateTime(2019, 11, 19),
            defaultDecoration: dateDecoration,
            selectedDecoration: selectedDateDecoration,
            initialSelectedDates: [DateTime(2019, 11, 18)],
            disabledDecoration: disabledDateDecoration,
            isDateDisabled: (date) =>
                date.compareTo(DateTime(2019, 11, 19)) == 0,
          ),
          textDirection: TextDirection.ltr,
        ),
      );

      WidgetPredicate datePredicate = (Widget widget) =>
          widget is Container && widget.decoration == dateDecoration;
      WidgetPredicate selectedDatePredicate = (Widget widget) =>
          widget is Container && widget.decoration == selectedDateDecoration;
      WidgetPredicate disabledDatePredicate = (Widget widget) =>
          widget is Container && widget.decoration == disabledDateDecoration;

      expect(find.byWidgetPredicate(datePredicate), findsOneWidget);
      expect(find.byWidgetPredicate(selectedDatePredicate), findsOneWidget);
      expect(find.byWidgetPredicate(disabledDatePredicate), findsOneWidget);
    },
  );

  testWidgets(
    'State should change after tapping any of date',
    (WidgetTester tester) async {
      final dateDecoration = BoxDecoration(
        color: Colors.blue,
      );
      final selectedDateDecoration = BoxDecoration(
        color: Colors.green,
      );

      final disabledDateDecoration = BoxDecoration(
        color: Colors.grey,
      );

      await tester.pumpWidget(
        Directionality(
          child: HorizontalCalendar(
            firstDate: DateTime(2019, 11, 17),
            lastDate: DateTime(2019, 11, 19),
            defaultDecoration: dateDecoration,
            selectedDecoration: selectedDateDecoration,
            initialSelectedDates: [DateTime(2019, 11, 18)],
            disabledDecoration: disabledDateDecoration,
            isDateDisabled: (date) =>
                date.compareTo(DateTime(2019, 11, 19)) == 0,
            onDateSelected: (date) => print("S:$date"),
            onDateUnSelected: (date) => print("U:$date"),
            onDateLongTap: (date) => print("L:$date"),
          ),
          textDirection: TextDirection.ltr,
        ),
      );

      WidgetPredicate datePredicate = (Widget widget) =>
          widget is Container && widget.decoration == dateDecoration;
      WidgetPredicate selectedDatePredicate = (Widget widget) =>
          widget is Container && widget.decoration == selectedDateDecoration;
      WidgetPredicate disabledDatePredicate = (Widget widget) =>
          widget is Container && widget.decoration == disabledDateDecoration;

      expect(find.byWidgetPredicate(datePredicate), findsOneWidget);
      expect(find.byWidgetPredicate(selectedDatePredicate), findsOneWidget);
      expect(find.byWidgetPredicate(disabledDatePredicate), findsOneWidget);

      await tester
          .tap(find.byKey(Key(DateTime(2019, 11, 17).toIso8601String())));

      await tester.pumpAndSettle();
      expect(find.byWidgetPredicate(selectedDatePredicate), findsNWidgets(2));

      await tester
          .tap(find.byKey(Key(DateTime(2019, 11, 17).toIso8601String())));

      await tester.pumpAndSettle();
      expect(find.byWidgetPredicate(selectedDatePredicate), findsOneWidget);
    },
  );

  testWidgets(
    'onDateSelected callback should be invoked',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          child: HorizontalCalendar(
            firstDate: DateTime(2019, 11, 17),
            lastDate: DateTime(2019, 11, 19),
            initialSelectedDates: [DateTime(2019, 11, 18)],
            isDateDisabled: (date) =>
                date.compareTo(DateTime(2019, 11, 19)) == 0,
            onDateSelected: (date) => print("S:$date"),
            onDateUnSelected: (date) => print("U:$date"),
            onDateLongTap: (date) => print("L:$date"),
          ),
          textDirection: TextDirection.ltr,
        ),
      );

      expectLater(
        () => tester
            .tap(find.byKey(Key(DateTime(2019, 11, 17).toIso8601String()))),
        prints('S:${DateTime(2019, 11, 17)}\n'),
      );
    },
  );

  testWidgets(
    'onDateUnSelected callback should be invoked',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          child: HorizontalCalendar(
            firstDate: DateTime(2019, 11, 17),
            lastDate: DateTime(2019, 11, 19),
            initialSelectedDates: [DateTime(2019, 11, 18)],
            isDateDisabled: (date) =>
                date.compareTo(DateTime(2019, 11, 19)) == 0,
            onDateSelected: (date) => print("S:$date"),
            onDateUnSelected: (date) => print("U:$date"),
            onDateLongTap: (date) => print("L:$date"),
          ),
          textDirection: TextDirection.ltr,
        ),
      );

      expectLater(
        () => tester
            .tap(find.byKey(Key(DateTime(2019, 11, 18).toIso8601String()))),
        prints('U:${DateTime(2019, 11, 18)}\n'),
      );
    },
  );

  testWidgets(
    'onDateLongTap callback should be invoked',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          child: HorizontalCalendar(
            firstDate: DateTime(2019, 11, 17),
            lastDate: DateTime(2019, 11, 19),
            initialSelectedDates: [DateTime(2019, 11, 18)],
            isDateDisabled: (date) =>
                date.compareTo(DateTime(2019, 11, 19)) == 0,
            onDateSelected: (date) => print("S:$date"),
            onDateUnSelected: (date) => print("U:$date"),
            onDateLongTap: (date) => print("L:$date"),
          ),
          textDirection: TextDirection.ltr,
        ),
      );

      expectLater(
        () => tester.longPress(
            find.byKey(Key(DateTime(2019, 11, 18).toIso8601String()))),
        prints('L:${DateTime(2019, 11, 18)}\n'),
      );
    },
  );
}
