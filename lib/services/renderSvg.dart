import 'package:flutter_svg/flutter_svg.dart';

renderSvg(image, color) {
  return new SvgPicture.asset(
    image,
    height: 60,
    color: color,
    package: 'nutty_putty_avatars',
  );
}
