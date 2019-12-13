import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/painting.dart";
import "package:flutter/rendering.dart";
import "package:flutter/widgets.dart";
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';

class ColorChanger extends StatefulWidget {
  final HSVColor color;
  final ValueChanged<HSVColor> onChanged;

  ColorChanger({Key key, @required this.color, @required this.onChanged})
      : assert(color != null),
        super(key: key);

  @override
  _ColorChangerState createState() => new _ColorChangerState();
}

class _ColorChangerState extends State<ColorChanger> {
  double sliderValue = 1.0;
  List<Color> get valueColors =>
      [Colors.black, widget.color.withValue(1.0).toColor()];

  List<Color> palette = [
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.white,
    Colors.lightBlue,
  ];

  colorButton(value) {
    return new Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: new FloatingActionButton(
        backgroundColor: value,
        mini: true,
        onPressed: () {
          widget.onChanged(HSVColor.fromColor(value).withValue(sliderValue));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(
          height: 80,
          child: new ListView(
              scrollDirection: Axis.horizontal,
              children: palette
                  .map<Widget>(
                    (item) => colorButton(item),
                  )
                  .toList())),
      SizedBox(
        width: 300,
        child: new SliderPicker(
            min: 0.0,
            max: 1.0,
            value: widget.color.value,
            onChanged: (value) {
              widget.onChanged(widget.color.withValue(value));
              setState(() {
                sliderValue = value;
              });
            },
            colors: valueColors),
      )
    ]);
  }
}
