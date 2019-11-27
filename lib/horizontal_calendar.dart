library horizontal_calendar;

import 'package:flutter/material.dart';
import 'package:horizontal_calendar/date_helper.dart';
import 'package:horizontal_calendar/date_widget.dart';

typedef DateBuilder = bool Function(DateTime dateTime);

typedef DateSelectionCallBack = void Function(DateTime dateTime);

class HorizontalCalendar extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final double height;
  final TextStyle monthTextStyle;
  final TextStyle selectedMonthTextStyle;
  final String monthFormat;
  final TextStyle dateTextStyle;
  final TextStyle selectedDateTextStyle;
  final String dateFormat;
  final TextStyle weekDayTextStyle;
  final TextStyle selectedWeekDayTextStyle;
  final String weekDayFormat;
  final DateSelectionCallBack onDateSelected;
  final DateSelectionCallBack onDateLongTap;
  final DateSelectionCallBack onDateUnSelected;
  final Decoration selectedDecoration;
  final Decoration disabledDecoration;
  final DateBuilder isDateDisabled;
  final List<DateTime> initialSelectedDates;
  final ScrollController scrollController;
  final double spacingBetweenDates;
  final EdgeInsetsGeometry padding;

  HorizontalCalendar({
    Key key,
    this.height = 100,
    @required this.firstDate,
    @required this.lastDate,
    this.scrollController,
    this.onDateSelected,
    this.onDateLongTap,
    this.onDateUnSelected,
    this.monthTextStyle,
    this.selectedMonthTextStyle,
    this.monthFormat = 'MMM',
    this.dateTextStyle,
    this.selectedDateTextStyle,
    this.dateFormat = 'dd',
    this.weekDayTextStyle,
    this.selectedWeekDayTextStyle,
    this.weekDayFormat = 'EEE',
    this.selectedDecoration = const BoxDecoration(color: Colors.cyan),
    this.disabledDecoration = const BoxDecoration(color: Colors.grey),
    this.isDateDisabled,
    this.initialSelectedDates,
    this.spacingBetweenDates = 8.0,
    this.padding = const EdgeInsets.all(8.0),
  })  : assert(firstDate != null),
        assert(lastDate != null),
        super(key: key);

  @override
  _HorizontalCalendarState createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  final List<DateTime> allDates = [];
  final List<DateTime> selectedDates = [];

  @override
  void initState() {
    super.initState();
    allDates.addAll(getDateList(widget.firstDate, widget.lastDate));
    if (widget.initialSelectedDates != null) {
      selectedDates.addAll(widget.initialSelectedDates.map((toDateMonthYear)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: Center(
        child: ListView.builder(
          controller: widget.scrollController ?? ScrollController(),
          scrollDirection: Axis.horizontal,
          itemCount: allDates.length,
          itemBuilder: (context, index) {
            final date = allDates[index];
            return Row(
              children: <Widget>[
                DateWidget(
                  padding: widget.padding,
                  isSelected: selectedDates.contains(date),
                  isDisabled: widget.isDateDisabled != null
                      ? widget.isDateDisabled(date)
                      : false,
                  date: date,
                  monthTextStyle: widget.monthTextStyle,
                  selectedMonthTextStyle: widget.selectedMonthTextStyle,
                  monthFormat: widget.monthFormat,
                  dateTextStyle: widget.dateTextStyle,
                  selectedDateTextStyle: widget.selectedDateTextStyle,
                  dateFormat: widget.dateFormat,
                  weekDayTextStyle: widget.weekDayTextStyle,
                  selectedWeekDayTextStyle: widget.selectedWeekDayTextStyle,
                  weekDayFormat: widget.weekDayFormat,
                  selectedDecoration: widget.selectedDecoration,
                  disabledDecoration: widget.disabledDecoration,
                  onTap: () {
                    if (!selectedDates.contains(date)) {
                      selectedDates.add(date);
                      if (widget.onDateSelected != null) {
                        widget.onDateSelected(date);
                      }
                    } else {
                      final isRemoved = selectedDates.remove(date);
                      if (isRemoved && widget.onDateUnSelected != null) {
                        widget.onDateUnSelected(date);
                      }
                    }
                    setState(() {});
                  },
                  onLongTap: () => widget.onDateLongTap != null
                      ? widget.onDateLongTap(date)
                      : null,
                ),
                SizedBox(width: widget.spacingBetweenDates),
              ],
            );
          },
        ),
      ),
    );
  }
}
