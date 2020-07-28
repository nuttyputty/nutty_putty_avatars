import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/painting.dart";
import "package:flutter/rendering.dart";
import "package:flutter/widgets.dart";

import '../test.dart';

import '../../services/hexToColor.dart';

class ColorChanger extends StatefulWidget {
  final color;
  final onChanged;
  final List<String> palette;
  final activeHue;
  final displaySlider;
  final initialColor;
  final bg;
  ColorChanger(
      {Key key,
      @required this.color,
      @required this.onChanged,
      this.palette,
      this.displaySlider,
      this.bg,
      this.activeHue,
      this.initialColor})
      : super(key: key);

  @override
  _ColorChangerState createState() => new _ColorChangerState();
}

class _ColorChangerState extends State<ColorChanger>
    with TickerProviderStateMixin {
  var activeColor;
  var activeHue;
  var activeSat;
  initState() {
    super.initState();

    setState(() {
      activeHue = HSLColor.fromColor(hexToColor(widget.color)).hue;
      activeSat = HSLColor.fromColor(hexToColor(widget.color)).saturation;
    });
  }

  colorButton(value, index) {
    bool active;

    active = activeHue == HSLColor.fromColor(value).hue &&
        activeSat == HSLColor.fromColor(value).saturation;
    return new SizedBox(
        width: 23,
        height: 23,
        child: FloatingActionButton(
            heroTag: index,
            onPressed: () {
              widget.onChanged(value);
              setState(() {
                activeHue = HSLColor.fromColor(value).hue;
                activeSat = HSLColor.fromColor(value).saturation;
              });
            },
            mini: true,
            child: Container(
                decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: active ? Border.all(width: 2, color: Colors.white) : null,
              color: value,
            ))));
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: widget.displaySlider ? 115 : 61,
      padding: EdgeInsets.only(left: 14, right: 14, top: 18, bottom: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.45, 1],
          colors: widget.bg != null
              ? [widget.bg, widget.bg]
              : [
                  hexToColor('#E3EDF7').withOpacity(1),
                  Color.fromRGBO(255, 255, 255, 0.7)
                ],
        ),
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Color.fromRGBO(255, 255, 255, 0.4),
        //     offset: Offset(-5, -5),
        //     blurRadius: 2,
        //   ),
        //   BoxShadow(
        //     color: Color.fromRGBO(152, 176, 199, 0.25),
        //     offset: Offset(3, 3),
        //     blurRadius: 10,
        //   ),
        // ]
      ),
      child: new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        new Padding(
          padding: EdgeInsets.only(left: 12, right: 12),
          child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget.palette.map<Widget>(((item) {
                var index = widget.palette.indexOf(item);
                return colorButton(hexToColor(item), index);
              })).toList()),
        ),
        widget.displaySlider
            ? SizedBox(
                height: 54,
                width: 230,
                child: new Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: new RotationTransition(
                        turns: new AlwaysStoppedAnimation(00 / 360),
                        child: CircleColorPicker(
                          initialColor: hexToColor(widget.color),
                          initialHue: activeHue,
                          onChanged: (v) {
                            widget.onChanged(v);
                          },
                          thumbSize: 45,
                        ))),
              )
            : Container(),
      ]),
    );
  }
}
