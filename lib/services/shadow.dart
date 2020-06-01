import 'package:flutter/widgets.dart';
import 'package:nutty_putty_avatars/services/hexToColor.dart';

calculateShadowColor(color) {
  var a = HSLColor.fromColor(hexToColor(color))
      .withLightness(HSLColor.fromColor(hexToColor(color)).lightness - 0.5 > 0.0
          ? HSLColor.fromColor(hexToColor(color)).lightness - 0.18
          : 0.3)
      .toColor();
  return '#${a.value.toRadixString(16)}';
}
