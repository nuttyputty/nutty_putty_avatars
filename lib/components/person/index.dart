import 'package:flutter/material.dart';
import 'package:nutty_putty_avatars/services/hexToColor.dart';
import 'package:nutty_putty_avatars/styles/index.dart';

import '../../services/renderSvg.dart';
import '../../services/shadow.dart';

class Person extends StatelessWidget {
  Person(
      {@required this.head,
      @required this.hair,
      @required this.eyes,
      @required this.mouth,
      @required this.clothes,
      @required this.noses,
      @required this.eyebrows,
      @required this.faceHair,
      @required this.headColor,
      @required this.hairColor,
      @required this.bgColor,
      @required this.background,
      @required this.accessories,
      @required this.isFree,
      @required this.eyesColor,
      @required this.hats,
      @required this.mouthColor,
      @required this.clothesColor,
      this.active});
  final head;
  final hair;
  final faceHair;
  final bgColor;
  final eyes;
  final eyebrows;
  final noses;
  final hats;
  final active;
  final mouth;
  final background;
  final clothes;
  final accessories;
  final headColor;
  final hairColor;
  final eyesColor;
  final mouthColor;
  final clothesColor;
  final isFree;
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        active != null && active
            ? Padding(
                padding: EdgeInsets.only(top: 10),
                child: Image(
                  height: 25.8,
                  width: 25.8,
                  image: AssetImage('assets/images/Circle.png',
                      package: 'nutty_putty_avatars'),
                ),
              )
            : Container(
                width: 0,
                height: 0,
              ),
        background['free']
            ? renderSvgWithColor(background['image'], bgColor)
            : renderSvg(background['image']),
        hats['back_image'] != null
            ? renderSvg(hats['back_image'])
            : Container(
                width: 0,
                height: 0,
              ),
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
        renderSvg(eyebrows['image']),
        hair['image'] != null
            ? renderSvgWithColor(hair['image'], hairColor)
            : Container(
                width: 0,
                height: 0,
              ),
        hair['shadow_image'] != null
            ? renderSvgWithColor(
                hair['shadow_image'], calculateShadowColor(hairColor))
            : Container(
                width: 0,
                height: 0,
              ),
        renderSvg(eyes['image']),
        eyes['shadow_image'] != null
            ? renderSvgWithColor(eyes['shadow_image'], eyesColor)
            : Container(
                width: 0,
                height: 0,
              ),
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
        renderSvgWithColor(noses['image'], calculateShadowColor(headColor)),
        hats['image'] != null
            ? renderSvg(hats['image'])
            : Container(
                width: 0,
                height: 0,
              ),
        accessories['image'] != null
            ? renderSvg(accessories['image'])
            : Container(
                width: 0,
                height: 0,
              ),
        !isFree
            ? Positioned(
                bottom: 13,
                right: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: hexToColor('#e8f1f9'),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(152, 176, 199, 0.3),
                        offset: Offset(0, 0),
                        blurRadius: 5.0,
                      )
                    ],
                  ),
                  width: 10,
                  height: 10,
                  padding: EdgeInsets.all(3),
                  alignment: Alignment.center,
                  child: renderSvgWithColor(
                      'assets/images/lock.svg', hexToColor('#8d9cb3'), true),
                ),
              )
            : Container(
                width: 0,
                height: 0,
              )
      ],
    );
  }
}
