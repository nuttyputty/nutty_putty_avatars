import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutty_putty_avatars/services/hexToColor.dart';

renderSvgWithColor(image, color, [assets]) {
  print(color);
  if (assets != null) {
    return new SvgPicture.asset(
      image,
      height: 60,
      color: hexToColor(color),
      package: 'nutty_putty_avatars',
    );
  }

  return new SvgPicture.network(
    image,
    height: 60,
    color: hexToColor(color),
  );
}

renderSvg(image) {
  print('asad');
  return new SvgPicture.network(
    image,
    height: 60,
  );
}
