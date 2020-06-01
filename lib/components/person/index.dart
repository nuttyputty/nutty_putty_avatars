import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutty_putty_avatars/blocks/blocs.dart';
import 'package:nutty_putty_avatars/models/person.dart';
import 'package:nutty_putty_avatars/services/hexToColor.dart';
import 'package:nutty_putty_avatars/styles/index.dart';

import '../../services/renderSvg.dart';
import '../../services/shadow.dart';

class PersonMaket extends StatelessWidget {
  Widget build(BuildContext context) {
    print('aa');
    return BlocConsumer<PersonBloc, PersonState>(
      listener: (BuildContext context, PersonState state) {},
      builder: (BuildContext context, PersonState state) {
        if (state is PersonLoaded) {
          return renderPerson(state.person);
        }

        return Container(
          height: 40,
          width: 40,
          color: Colors.yellow,
        );
      },
    );
  }
}

Widget renderPerson(Person person) {
  print(person.clothes.element.shadowImage);
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      // active != null && active
      //     ? Padding(
      //         padding: EdgeInsets.only(top: 10),
      //         child: Image(
      //           height: 25.8,
      //           width: 25.8,
      //           image: AssetImage('assets/images/Circle.png',
      //               package: 'nutty_putty_avatars'),
      //         ),
      //       )
      //     : Container(
      //         width: 0,
      //         height: 0,
      //       ),
      person.background.element.free
          ? renderSvgWithColor(
              person.background.element.image, person.background.color)
          : renderSvg(person.background.element.image),
      person.hats.element.backImage != null
          ? renderSvg(person.hats.element.backImage)
          : Container(
              width: 0,
              height: 0,
            ),
      person.hair.element.longHairImage != null
          ? renderSvgWithColor(
              person.hair.element.longHairImage, person.hair.color)
          : Container(
              width: 0,
              height: 0,
            ),
      renderSvgWithColor(person.head.element.image, person.head.color),
      person.head.element.shadowImage != null
          ? renderSvgWithColor(person.head.element.shadowImage,
              calculateShadowColor(person.head.color))
          : Container(
              width: 0,
              height: 0,
            ),
      renderSvg(person.eyebrows.element.image),
      person.hair.element.image != null
          ? renderSvgWithColor(person.hair.element.image, person.hair.color)
          : Container(
              width: 0,
              height: 0,
            ),
      person.hair.element.shadowImage != null
          ? renderSvgWithColor(person.hair.element.shadowImage,
              calculateShadowColor(person.hair.color))
          : Container(
              width: 0,
              height: 0,
            ),
      renderSvg(person.eyes.element.image),
      person.eyes.element.shadowImage != null
          ? renderSvgWithColor(
              person.eyes.element.shadowImage, person.eyes.color)
          : Container(
              width: 0,
              height: 0,
            ),
      person.clothes.element.shadowImage != null
          ? renderSvgWithColor(
              person.clothes.element.image, person.clothes.color)
          : renderSvg(person.clothes.element.image),
      person.clothes.element.shadowImage != null
          ? renderSvgWithColor(person.clothes.element.shadowImage,
              calculateShadowColor(person.clothes.color))
          : Container(
              width: 0,
              height: 0,
            ),
      renderSvgWithColor(
          person.faceHairs.element.image, person.faceHairs.color),
      renderSvg(person.mouth.element.image),
      person.faceHairs.element.shadowImage != null
          ? renderSvgWithColor(person.faceHairs.element.shadowImage,
              calculateShadowColor(person.faceHairs.color))
          : Container(
              width: 0,
              height: 0,
            ),
      renderSvgWithColor(
          person.noses.element.image, calculateShadowColor(person.head.color)),
      person.hats.element.image != null
          ? renderSvg(person.hats.element.image)
          : Container(
              width: 0,
              height: 0,
            ),
      person.accessories.element.image != null
          ? renderSvg(person.accessories.element.image)
          : Container(
              width: 0,
              height: 0,
            ),
      // !isFree
      //     ? Positioned(
      //         bottom: 13,
      //         right: 3,
      //         child: Container(
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(50),
      //             color: hexToColor('#e8f1f9'),
      //             boxShadow: <BoxShadow>[
      //               BoxShadow(
      //                 color: Color.fromRGBO(152, 176, 199, 0.3),
      //                 offset: Offset(0, 0),
      //                 blurRadius: 5.0,
      //               )
      //             ],
      //           ),
      //           width: 10,
      //           height: 10,
      //           padding: EdgeInsets.all(3),
      //           alignment: Alignment.center,
      //           child: renderSvgWithColor(
      //               'assets/images/lock.svg', hexToColor('#8d9cb3'), true),
      //         ),
      //       )
      //     : Container(
      //         width: 0,
      //         height: 0,
      //       )
    ],
  );
}
