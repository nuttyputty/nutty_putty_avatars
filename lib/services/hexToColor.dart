import 'package:flutter/material.dart';

Color hexToColor(String code) {
  // print(c.value.toRadixString(16).replaceFirst('ff', '#'));
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

String colorToHex(Color color) {
  return color.value.toRadixString(16).replaceFirst('ff', '#');
}
