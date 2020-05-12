import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircleColorPicker extends StatefulWidget {
  const CircleColorPicker(
      {Key key,
      this.onChanged,
      this.size = const Size(280, 280),
      this.strokeWidth = 2,
      this.thumbSize = 32,
      this.initialColor,
      this.initialHue,
      this.initialLightness})
      : super(key: key);

  final ValueChanged<Color> onChanged;

  final Size size;

  /// The width of circle border.
  ///
  /// Default value is 2.
  final double strokeWidth;

  /// The size of thumb for circle picker.
  ///
  /// Default value is 32.
  final double thumbSize;

  /// Initial color for picker.
  /// [onChanged] callback won't be called with initial value.
  ///
  /// Default value is Red.
  final Color initialColor;
  final initialHue;
  final initialLightness;

  @override
  _CircleColorPickerState createState() => _CircleColorPickerState();
}

class _CircleColorPickerState extends State<CircleColorPicker>
    with TickerProviderStateMixin {
  AnimationController _lightnessController;

  Color get _color {
    return HSLColor.fromAHSL(
      1,
      widget.initialHue,
      1,
      _lightnessController.value,
    ).toColor();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 40,
      child: Stack(
        children: <Widget>[
          AnimatedBuilder(
            animation: _lightnessController,
            builder: (context, _) {
              return Center(
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                const SizedBox(height: 16, width: 230),
                _LightnessSlider(
                  initialLightness: widget.initialLightness,
                  width: 230,
                  thumbSize: 26,
                  hue: widget.initialHue,
                  onChanged: (lightness) {
                    _lightnessController.value = lightness;
                  },
                )
              ]));
            },
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _lightnessController = AnimationController(
      vsync: this,
      value: HSLColor.fromColor(widget.initialColor).lightness,
      lowerBound: 0,
      upperBound: 1,
    )..addListener(_onColorChanged);
  }

  void _onColorChanged() {
    widget.onChanged?.call(_color);
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
                  child: ScaleTransition(
                    scale: _scaleController,
                    child: _Thumb(
                      size: widget.thumbSize,
                      color: HSLColor.fromAHSL(
                        1,
                        widget.hue,
                        1,
                        _lightnessController.value,
                      ).toColor(),
                    ),
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
      upperBound: 1,
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

class _Thumb extends StatelessWidget {
  const _Thumb({Key key, this.size, this.color}) : super(key: key);

  final double size;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(255, 255, 255, 255),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(16, 0, 0, 0),
            blurRadius: 4,
            spreadRadius: 4,
          )
        ],
      ),
      alignment: Alignment.center,
      child: Container(
        width: size - 6,
        height: size - 6,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
