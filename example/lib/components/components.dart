import 'package:flutter/material.dart';

class PropertyLabel extends StatelessWidget {
  final String label;
  final Widget value;
  final VoidCallback onTap;

  const PropertyLabel({
    Key key,
    this.label,
    this.value,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      subtitle: value,
      onTap: onTap,
    );
  }
}

class DropDownProperty<T> extends StatelessWidget {
  final String hint;
  final T value;
  final List<T> options;
  final Function(T selectedValue) onChange;

  const DropDownProperty({
    Key key,
    @required this.hint,
    @required this.value,
    @required this.options,
    @required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        hint: Text(hint),
        value: value,
        items: options.map((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(value.toString()),
          );
        }).toList(),
        onChanged: (format) {
          if (format != null) {
            onChange(format);
          }
        },
      ),
    );
  }
}

class ColorDropDown extends StatelessWidget {
  final String hint;
  final Color value;
  final List<Color> options;
  final Function(Color selectedValue) onChange;

  const ColorDropDown({
    Key key,
    @required this.hint,
    @required this.value,
    this.options = const [
      Colors.transparent,
      Colors.blue,
      Colors.purple,
      Colors.yellow,
      Colors.green,
      Colors.grey,
    ],
    @required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<Color>(
        hint: Text(hint),
        value: value,
        items: options.map((Color value) {
          return DropdownMenuItem<Color>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 50,
                color: value,
              ),
            ),
          );
        }).toList(),
        onChanged: (format) {
          if (format != null) {
            onChange(format);
          }
        },
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String headerText;

  const Header({Key key, this.headerText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 16,
          ),
          child: Row(
            children: <Widget>[
              Text(
                headerText,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 2,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DecorationBuilder extends StatelessWidget {
  final BoxShape decorationShape;
  final Function(BoxShape) onSelectShape;
  final bool isCircularRadius;
  final Function(bool) onCircularRadiusChange;
  final Color color;
  final Function(Color) onColorChange;

  const DecorationBuilder({
    Key key,
    @required this.decorationShape,
    @required this.onSelectShape,
    @required this.isCircularRadius,
    @required this.onCircularRadiusChange,
    @required this.color,
    @required this.onColorChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        PropertyLabel(
          label: 'Decoration Shape',
          value: DropDownProperty<BoxShape>(
            hint: 'Select Decoration Type',
            value: decorationShape,
            options: BoxShape.values,
            onChange: onSelectShape,
          ),
        ),
        if (decorationShape == BoxShape.rectangle)
          PropertyLabel(
            label: 'Is Circular Border?',
            value: Checkbox(
              value: isCircularRadius,
              onChanged: onCircularRadiusChange,
            ),
          ),
        PropertyLabel(
          label: 'Decoration Color',
          value: ColorDropDown(
            hint: 'Select Decoration Color',
            value: color,
            onChange: onColorChange,
          ),
        ),
      ],
    );
  }
}

typedef RangeSelectionCallback = void Function(RangeValues newRange);

class CustomRangeSlider extends StatefulWidget {
  final RangeValues range;
  final double min;
  final double max;
  final RangeSelectionCallback onRangeSet;

  CustomRangeSlider({
    @required this.range,
    @required this.onRangeSet,
    this.min,
    this.max,
  }) : assert(range != null);

  @override
  _CustomRangeSliderState createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  RangeValues range;

  @override
  void initState() {
    super.initState();
    range = widget.range;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          "${range.start.toInt()}",
          style: Theme.of(context).textTheme.headline6,
        ),
        Expanded(
          child: RangeSlider(
            values: range,
            min: widget.min,
            max: widget.max,
            divisions: widget.max.toInt(),
            onChanged: (newRange) => {
              setState(() {
                range = newRange;
                if (widget.onRangeSet != null) {
                  widget.onRangeSet(newRange);
                }
              })
            },
          ),
        ),
        Text(
          "${range.end.toInt()}",
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}
