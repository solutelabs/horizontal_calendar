# horizontal_calendar

An Example Application that demonstrate all features provided by horizontal_calendar

## Getting Started

To watch demo, clone repo and execute
```
cd example/
flutter run
```

To use in your application:

```dart
class HorizontalCalendarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HorizontalCalendar(
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 15),
      ),
      //pass other properties as required
    );
  }
}
```