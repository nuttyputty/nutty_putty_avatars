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
      @required this.headColor,
      @required this.hairColor,
      @required this.eyesColor,
      @required this.mouthColor,
      @required this.clothesColor});
  final head;
  final hair;
  final eyes;
  final mouth;
  final clothes;
  final headColor;
  final hairColor;
  final eyesColor;
  final mouthColor;
  final clothesColor;

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        renderSvg(head['image'], headColor.toColor()),
        renderSvg(head['shadow'], calculateShadowColor(headColor)),
        renderSvg(hair['image'], hairColor.toColor()),
        renderSvg(hair['shadow'], calculateShadowColor(hairColor)),
        renderSvg(eyes['image'], eyesColor),
        renderSvg(mouth['image'], mouthColor),
        renderSvg(clothes['image'], clothesColor.toColor()),
      ],
    );
  }
}
