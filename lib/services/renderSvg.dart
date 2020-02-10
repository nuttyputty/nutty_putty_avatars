import 'package:flutter_svg/flutter_svg.dart';

renderSvgWithColor(image, color, [assets]) {
  if (assets != null) {
    return new SvgPicture.asset(
      image,
      height: 60,
      color: color,
      package: 'nutty_putty_avatars',
    );
  }

  return new SvgPicture.network(
    image,
    height: 60,
    color: color,
  );
}

renderSvg(image) {
  return new SvgPicture.network(
    image,
    height: 60,
  );
}
