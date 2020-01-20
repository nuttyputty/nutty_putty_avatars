// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// import 'package:flutter_colorpicker/utils.dart';

class CircleColorPicker extends StatefulWidget {
  const CircleColorPicker({
    Key key,
    this.onChanged,
    this.strokeWidth = 2,
    this.thumbSize = 32,
    this.initialColor,
    this.initialHue,
  }) : super(key: key);

  final onChanged;

  final double strokeWidth;

  final double thumbSize;

  final Color initialColor;

  final initialHue;

  double get initialLightness => HSLColor.fromColor(initialColor).lightness;

  // double get initialHue => HSLColor.fromColor(initialColor).hue;

  @override
  _CircleColorPickerState createState() => _CircleColorPickerState();
}

class _CircleColorPickerState extends State<CircleColorPicker>
    with TickerProviderStateMixin {
  AnimationController _lightnessController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 40,
      child: AnimatedBuilder(
        animation: _lightnessController,
        builder: (context, _) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 16, width: 230),
                _LightnessSlider(
                  initialLightness: widget.initialLightness,
                  width: 230,
                  thumbSize: 26,
                  hue: HSLColor.fromColor(widget.initialColor).hue,
                  onChanged: (lightness) {
                    _lightnessController.value = lightness;
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _lightnessController = AnimationController(
      vsync: this,
      value: widget.initialLightness,
      lowerBound: 0,
      upperBound: 1,
    )..addListener(_onColorChanged);
  }

  void _onColorChanged() {
    widget.onChanged(HSLColor.fromColor(widget.initialColor)
        .withHue(widget.initialHue)
        .withLightness(_lightnessController.value));
  }
}

class _LightnessSlider extends StatefulWidget {
  const _LightnessSlider({
    Key key,
    this.hue,
    this.width,
    this.onChanged,
    this.thumbSize,
    this.initialLightness,
  }) : super(key: key);

  final double hue;

  final double width;

  final ValueChanged<double> onChanged;

  final double thumbSize;

  final double initialLightness;

  @override
  _LightnessSliderState createState() => _LightnessSliderState();
}

class _LightnessSliderState extends State<_LightnessSlider>
    with TickerProviderStateMixin {
  AnimationController _lightnessController;
  AnimationController _scaleController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Container(
        width: widget.width,
        height: widget.thumbSize,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 40,
              margin: EdgeInsets.symmetric(
                horizontal: widget.thumbSize / 40,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                gradient: LinearGradient(
                  stops: [0, 0.4, 1],
                  colors: [
                    HSLColor.fromAHSL(1, widget.hue, 1, 0).toColor(),
                    HSLColor.fromAHSL(1, widget.hue, 1, 0.5).toColor(),
                    HSLColor.fromAHSL(1, widget.hue, 1, 0.9).toColor(),
                  ],
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _lightnessController,
              builder: (context, child) {
                return Positioned(
                  left: _lightnessController.value *
                      (widget.width - widget.thumbSize),
                  child: Container(
                    width: widget.thumbSize,
                    height: widget.thumbSize,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 2, color: Colors.white),
                        color: HSLColor.fromAHSL(
                          1,
                          widget.hue,
                          1,
                          _lightnessController.value,
                        ).toColor()),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _lightnessController = AnimationController(
      vsync: this,
      value: widget.initialLightness,
    )..addListener(() => widget.onChanged(_lightnessController.value));
    _scaleController = AnimationController(
      vsync: this,
      value: 1,
      lowerBound: 0.9,
      upperBound: 0.9,
      duration: Duration(milliseconds: 50),
    );
  }

  void _onPanStart(DragStartDetails details) {
    _scaleController.reverse();
    _lightnessController.value = details.localPosition.dx / widget.width;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _lightnessController.value = details.localPosition.dx / widget.width;
  }

  void _onPanEnd(DragEndDetails details) {
    _scaleController.forward();
  }
}
