import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutty_putty_avatars/blocks/blocs.dart';
// import 'package:nutty_putty_avatars/models/part.dart' as model;
import 'package:nutty_putty_avatars/models/person.dart' as model;
import 'package:nutty_putty_avatars/services/hexToColor.dart';

import '../../services/renderSvg.dart';
import '../../services/shadow.dart';

class PersonMaket extends StatefulWidget {
  PersonMaket(
      {@required this.head,
      @required this.hair,
      @required this.eyes,
      @required this.mouth,
      @required this.clothes,
      @required this.noses,
      @required this.eyebrows,
      @required this.faceHairs,
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
  // final model.Person customPerson;

  final model.Element head;
  final model.Element hair;
  final faceHairs;
  final bgColor;
  final model.Element eyes;
  final model.Element eyebrows;
  final model.Element noses;
  final model.Element hats;
  final active;
  final model.Element mouth;
  final model.Element background;
  final model.Element clothes;
  final model.Element accessories;
  final headColor;
  final hairColor;
  final eyesColor;
  final mouthColor;
  final clothesColor;
  final isFree;

  _PersonMaketState createState() => _PersonMaketState();
}

class _PersonMaketState extends State<PersonMaket> {
  PersonBloc _personBloc;

  @override
  void initState() {
    super.initState();
    _personBloc = BlocProvider.of<PersonBloc>(context);
  }

  Widget build(BuildContext context) {
    // if (widget.customPerson != null) {
    //   print('asdasd');
    //   _personBloc.add(CustomPerson(background: widget.customPerson));
    // }
    // return BlocConsumer<PersonBloc, PersonState>(
    //   listener: (BuildContext context, PersonState state) {},
    //   builder: (BuildContext context, PersonState state) {
    //     if (state is PersonLoaded) {
    // if (widget.customPerson != null) {
    //   print('asdasd');
    //   _personBloc.add(CustomPerson(background: widget.customPerson));
    // }

    return renderPerson(
        active: widget.active,
        background: widget.background,
        accessories: widget.accessories,
        backgroundColor: widget.bgColor,
        clothes: widget.clothes,
        clothesColor: widget.clothesColor,
        eyebrows: widget.eyebrows,
        eyes: widget.eyes,
        eyesColor: widget.eyesColor,
        face_hairs: widget.faceHairs,
        face_hairsColor: widget.hairColor,
        hair: widget.hair,
        hairColor: widget.hairColor,
        hats: widget.hats,
        head: widget.head,
        headColor: widget.headColor,
        mouth: widget.mouth,
        noses: widget.noses,
        isFree: widget.isFree);
  }

  // return Container(
  //   height: 40,
  //   width: 40,
  //   color: Colors.yellow,
  // );
  // },
  // );
}
// }

Widget renderPerson(
    {bool active,
    String backgroundColor,
    model.Element background,
    String headColor,
    model.Element head,
    String hairColor,
    model.Element hair,
    model.Element hats,
    String eyesColor,
    model.Element eyes,
    model.Element mouth,
    model.Element noses,
    String face_hairsColor,
    model.Element face_hairs,
    String clothesColor,
    model.Element clothes,
    model.Element accessories,
    model.Element eyebrows,
    bool isFree}) {
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
      background.customColor != null
          ? background.customColor
              ? renderSvgWithColor(background.image, backgroundColor)
              : renderSvg(background.image)
          : background.free
              ? renderSvgWithColor(background.image, backgroundColor)
              : renderSvg(background.image),
      hats.backImage != null
          ? renderSvg(hats.backImage)
          : Container(
              width: 0,
              height: 0,
            ),
      hair.longHairImage != null
          ? renderSvgWithColor(hair.longHairImage, hairColor)
          : Container(
              width: 0,
              height: 0,
            ),
      renderSvgWithColor(head.image, headColor),
      head.shadowImage != null
          ? renderSvgWithColor(
              head.shadowImage, calculateShadowColor(headColor))
          : Container(
              width: 0,
              height: 0,
            ),
      renderSvg(eyebrows.image),
      hair.image != null
          ? renderSvgWithColor(hair.image, hairColor)
          : Container(
              width: 0,
              height: 0,
            ),
      hair.shadowImage != null
          ? renderSvgWithColor(
              hair.shadowImage, calculateShadowColor(hairColor))
          : Container(
              width: 0,
              height: 0,
            ),
      renderSvg(eyes.image),
      eyes.shadowImage != null
          ? renderSvgWithColor(eyes.shadowImage, eyesColor)
          : Container(
              width: 0,
              height: 0,
            ),
      clothes.shadowImage != null
          ? renderSvgWithColor(clothes.image, clothesColor)
          : renderSvg(clothes.image),
      clothes.shadowImage != null
          ? renderSvgWithColor(
              clothes.shadowImage, calculateShadowColor(clothesColor))
          : Container(
              width: 0,
              height: 0,
            ),
      face_hairs != null
          ? renderSvgWithColor(face_hairs.image, face_hairsColor)
          : SizedBox(),
      renderSvg(mouth.image),
      face_hairs.shadowImage != null
          ? renderSvgWithColor(
              face_hairs.shadowImage, calculateShadowColor(face_hairsColor))
          : Container(
              width: 0,
              height: 0,
            ),
      renderSvgWithColor(noses.image, calculateShadowColor(headColor)),
      hats.image != null
          ? renderSvg(hats.image)
          : Container(
              width: 0,
              height: 0,
            ),
      accessories.image != null
          ? renderSvg(accessories.image)
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
