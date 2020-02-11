import 'package:flutter/material.dart';

import '../../services/renderSvg.dart';
import '../../services/shadow.dart';

class Person extends StatelessWidget {
  Person(
      {@required this.head,
      @required this.hair,
      @required this.eyes,
      @required this.mouth,
      @required this.clothes,
      @required this.faceHair,
      @required this.headColor,
      @required this.hairColor,
      @required this.bgColor,
      @required this.background,
      @required this.accessories,
      @required this.eyesColor,
      @required this.mouthColor,
      @required this.clothesColor});
  final head;
  final hair;
  final faceHair;
  final bgColor;
  final eyes;
  final mouth;
  final background;
  final clothes;
  final accessories;
  final headColor;
  final hairColor;
  final eyesColor;
  final mouthColor;
  final clothesColor;

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        renderSvgWithColor(background['image'], bgColor),
        hair['long_hair_image'] != null
            ? renderSvgWithColor(hair['long_hair_image'], hairColor)
            : Container(
                width: 0,
                height: 0,
              ),
        renderSvgWithColor(head['image'], headColor),
        head['shadow_image'] != null
            ? renderSvgWithColor(
                head['shadow_image'], calculateShadowColor(headColor))
            : Container(
                width: 0,
                height: 0,
              ),
        renderSvgWithColor(hair['image'], hairColor),
        hair['shadow_image'] != null
            ? renderSvgWithColor(
                hair['shadow_image'], calculateShadowColor(hairColor))
            : Container(
                width: 0,
                height: 0,
              ),
        renderSvg(eyes['image']),
        renderSvg(accessories['image']),
        renderSvgWithColor(clothes['image'], clothesColor),
        clothes['shadow_image'] != null
            ? renderSvgWithColor(
                clothes['shadow_image'], calculateShadowColor(clothesColor))
            : Container(
                width: 0,
                height: 0,
              ),
        renderSvgWithColor(faceHair['image'], hairColor),
        renderSvg(mouth['image']),
        faceHair['shadow_image'] != null
            ? renderSvgWithColor(
                faceHair['shadow_image'], calculateShadowColor(hairColor))
            : Container(
                width: 0,
                height: 0,
              ),
      ],
    );
  }
}
