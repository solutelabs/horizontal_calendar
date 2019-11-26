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
  final TextStyle dayTextStyle;
  final TextStyle selectedDayTextStyle;
  final String dayFormat;
  final VoidCallback onTap;
  final VoidCallback onLongTap;
  final Decoration selectedDecoration;
  final Decoration disabledDecoration;
  final isSelected;
  final isDisabled;

  DateWidget({
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
    this.dayTextStyle,
    this.selectedDayTextStyle,
    this.dayFormat,
    this.selectedDecoration,
    this.disabledDecoration,
  });

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
        ? selectedDayTextStyle ?? dayTextStyle ?? subTitleStyle
        : dayTextStyle ?? subTitleStyle;

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      onLongPress: isDisabled ? null : onLongTap,
      child: Container(
        decoration: isSelected
            ? selectedDecoration
            : isDisabled ? disabledDecoration : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
              if (dayFormat != null)
                Text(
                  DateFormat(dayFormat).format(date),
                  style: dayStyle,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
