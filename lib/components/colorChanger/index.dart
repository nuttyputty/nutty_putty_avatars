import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/painting.dart";
import "package:flutter/rendering.dart";
import "package:flutter/widgets.dart";

import '../../services/hexToColor.dart';

class ColorChanger extends StatefulWidget {
  final color;
  final onChanged;
  final List<String> palette;
  final activeHue;
  final initialColor;
  final bg;
  ColorChanger(
      {Key key,
      @required this.color,
      @required this.onChanged,
      this.palette,
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
      activeHue = HSLColor.fromColor(widget.color).hue;
      activeSat = HSLColor.fromColor(widget.color).saturation;
    });
  }

  colorButton(value, index) {
    bool active;

    active = activeHue == HSLColor.fromColor(value).hue &&
        activeSat == HSLColor.fromColor(value).saturation;
    return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: SizedBox(
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
                    height: 23,
                    width: 23,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: active
                          ? Border.all(width: 2, color: Colors.white)
                          : null,
                      color: value,
                    )))));
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return new Container(
      height: 80,
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
          boxShadow: <BoxShadow>[
            // BoxShadow(
            //   color: Color.fromRGBO(255, 255, 255, 0.4),
            //   offset: Offset(-5, -5),
            //   blurRadius: 2,
            // ),
            // BoxShadow(
            //   color: Color.fromRGBO(152, 176, 199, 0.25),
            //   offset: Offset(3, 3),
            //   blurRadius: 10,
            // ),
          ]),
      child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: FadingEdgeScrollView.fromScrollView(
            child: ListView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: widget.palette.map<Widget>(((item) {
                  var index = widget.palette.indexOf(item);
                  return colorButton(hexToColor(item), index);
                })).toList()),
          )),
    );
  }
}
