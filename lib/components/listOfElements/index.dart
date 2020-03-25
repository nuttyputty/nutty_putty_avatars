import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nutty_putty_avatars/components/person/index.dart';

import '../../services/hexToColor.dart';

class ListOfElements extends StatelessWidget {
  ListOfElements(
      {@required this.list,
      @required this.partOfAvatar,
      @required this.changeActiveElement,
      @required this.head,
      @required this.hair,
      @required this.eyes,
      @required this.mouth,
      @required this.faceHair,
      @required this.clothes,
      @required this.accessories,
      @required this.noses,
      @required this.headColor,
      @required this.background,
      @required this.bgColor,
      @required this.hairColor,
      @required this.eyesColor,
      @required this.eyebrows,
      @required this.mouthColor,
      @required this.clothesColor,
      @required this.hats,
      this.fullVersion,
      this.color,
      this.hairs,
      this.hatHairs});
  final list;
  final int partOfAvatar;
  final Function changeActiveElement;
  final head;
  final hairs;
  final hatHairs;
  final bgColor;
  final noses;
  final hair;
  final eyes;
  final mouth;
  final background;
  final eyebrows;
  final accessories;
  final faceHair;
  final clothes;
  final headColor;
  final hairColor;
  final eyesColor;
  final mouthColor;
  final clothesColor;
  final color;
  final hats;
  final fullVersion;
  @override
  Widget build(BuildContext context) {
    print(' [LIST] $fullVersion');
    final double width = MediaQuery.of(context).size.width;
    return new Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      height: 78,
      constraints: BoxConstraints(minWidth: width),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.45, 1],
          colors: color != null
              ? [color, color]
              : [
                  hexToColor('#E3EDF7').withOpacity(1),
                  Color.fromRGBO(255, 255, 255, 0.7)
                ],
        ),
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Color.fromRGBO(255, 255, 255, 0.5),
        //     offset: Offset(-3, -3),
        //     blurRadius: 2,
        //   ),
        //   BoxShadow(
        //     color: Color.fromRGBO(152, 176, 199, 0.3),
        //     offset: Offset(3, 3),
        //     blurRadius: 10,
        //   ),
        // ],
      ),
      child: new ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: list['parts'].map<Widget>((item) {
          var hairPart = hair;
          if (list['subpart'] == 'hats') {
            var index = hatHairs.indexWhere((i) => hair['id'] == i['id']);

            if (index == -1) {
              index = hairs.indexWhere((i) => hair['id'] == i['id']);
            }
            if (index != -1) {
              hairPart = item['image'] != null ? hatHairs[index] : hairs[index];
            }
          }
          return Padding(
              padding: EdgeInsets.only(left: 7.5, right: 7.5),
              child: new IconButton(
                  onPressed: () {
                    changeActiveElement(item);
                  },
                  icon: Transform.scale(
                      scale: 1.8,
                      child: Person(
                        isFree: fullVersion ? true : item['free'],
                        head: list['subpart'] == 'head' ? item : head,
                        headColor: headColor,
                        eyebrows:
                            list['subpart'] == 'eyebrows' ? item : eyebrows,
                        noses: list['subpart'] == 'noses' ? item : noses,
                        hair: list['subpart'] == 'hair' ? item : hairPart,
                        bgColor: bgColor,
                        hairColor: hairColor,
                        hats: list['subpart'] == 'hats' ? item : hats,
                        eyes: list['subpart'] == 'eyes' ? item : eyes,
                        mouth: list['subpart'] == 'mouth' ? item : mouth,
                        clothes: list['subpart'] == 'clothes' ? item : clothes,
                        background:
                            list['subpart'] == 'background' ? item : background,
                        faceHair:
                            list['subpart'] == 'face_hairs' ? item : faceHair,
                        clothesColor: clothesColor,
                        accessories: list['subpart'] == 'accessories'
                            ? item
                            : accessories,
                        eyesColor: eyesColor,
                        mouthColor: Colors.white,
                      ))));
        }).toList(),
      ),
    );
  }
}
