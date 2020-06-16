import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutty_putty_avatars/services/hexToColor.dart';

renderSvgWithColor(image, color, [assets]) {
  print(color);
  if (assets != null) {
    return new SvgPicture.asset(
      image,
      height: 60,
      color: color.runtimeType != Color ? hexToColor(color) : color,
      package: 'nutty_putty_avatars',
    );
  }

  return new SvgPicture.network(
    image,
    height: 60,
    color: color.runtimeType != Color ? hexToColor(color) : color,
  );
}

renderSvg(image) {
  print('asad');
  return new SvgPicture.network(
    image,
    height: 60,
  );
}
