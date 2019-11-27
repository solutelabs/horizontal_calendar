import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  final DateTime date;
  final TextStyle monthTextStyle;
  final TextStyle selectedMonthTextStyle;
  final String monthFormat;
  final TextStyle dateTextStyle;
  final TextStyle selectedDateTextStyle;
  final String dateFormat;
  final TextStyle weekDayTextStyle;
  final TextStyle selectedWeekDayTextStyle;
  final String weekDayFormat;
  final VoidCallback onTap;
  final VoidCallback onLongTap;
  final Decoration selectedDecoration;
  final Decoration disabledDecoration;
  final bool isSelected;
  final bool isDisabled;
  final EdgeInsetsGeometry padding;

  const DateWidget({
    Key key,
    @required this.date,
    this.onTap,
    this.onLongTap,
    this.isSelected = false,
    this.isDisabled = false,
    this.monthTextStyle,
    this.selectedMonthTextStyle,
    this.monthFormat,
    this.dateTextStyle,
    this.selectedDateTextStyle,
    this.dateFormat,
    this.weekDayTextStyle,
    this.selectedWeekDayTextStyle,
    this.weekDayFormat,
    this.selectedDecoration,
    this.disabledDecoration,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.title;
    final subTitleStyle = Theme.of(context).textTheme.subtitle;

    final monthStyle = isSelected
        ? selectedMonthTextStyle ?? monthTextStyle ?? subTitleStyle
        : monthTextStyle ?? subTitleStyle;
    final dateStyle = isSelected
        ? selectedDateTextStyle ?? dateTextStyle ?? titleStyle
        : dateTextStyle ?? titleStyle;
    final dayStyle = isSelected
        ? selectedWeekDayTextStyle ?? weekDayTextStyle ?? subTitleStyle
        : weekDayTextStyle ?? subTitleStyle;

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      onLongPress: isDisabled ? null : onLongTap,
      child: Container(
        decoration: isSelected
            ? selectedDecoration
            : isDisabled ? disabledDecoration : null,
        child: Padding(
          padding: padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (monthFormat != null)
                Text(
                  DateFormat(monthFormat).format(date),
                  style: monthStyle,
                ),
              Text(
                DateFormat(dateFormat).format(date),
                style: dateStyle,
              ),
              if (weekDayFormat != null)
                Text(
                  DateFormat(weekDayFormat).format(date),
                  style: dayStyle,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
