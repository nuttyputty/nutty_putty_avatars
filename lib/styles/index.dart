import 'package:flutter/painting.dart';
import 'package:nutty_putty_avatars/services/hexToColor.dart';

List<BoxShadow> shadow = <BoxShadow>[
  BoxShadow(
    color: Color.fromRGBO(255, 255, 255, 0.5),
    offset: Offset(-3, -3),
    blurRadius: 2,
  ),
  BoxShadow(
    color: Color.fromRGBO(152, 176, 199, 0.3),
    offset: Offset(3, 3),
    blurRadius: 10,
  ),
];

List<Color> gradient = [
  hexToColor('#E3EDF7').withOpacity(1),
  hexToColor('#E3EDF7').withOpacity(1),
  // Color.fromRGBO(255, 255, 255, 0.7)
];
