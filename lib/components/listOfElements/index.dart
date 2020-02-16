import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nutty_putty_avatars/components/person/index.dart';

import '../../services/renderSvg.dart';
import '../../services/shadow.dart';
import '../../services/hexToColor.dart';

class ListOfElements extends StatelessWidget {
  ListOfElements(
      {@required this.list,
      @required this.partOfAvatar,
      @required this.changeActiveElement,
      @required this.head,
      @required this.hair,
      @required this.secondList,
      @required this.eyes,
      @required this.mouth,
      @required this.faceHair,
      @required this.clothes,
      @required this.accessories,
      @required this.headColor,
      @required this.background,
      @required this.bgColor,
      @required this.hairColor,
      @required this.eyesColor,
      @required this.mouthColor,
      @required this.clothesColor});
  final List list;
  final int partOfAvatar;
  final Function changeActiveElement;
  final head;
  final secondList;
  final bgColor;
  final hair;
  final eyes;
  final mouth;
  final background;
  final accessories;
  final faceHair;
  final clothes;
  final headColor;
  final hairColor;
  final eyesColor;
  final mouthColor;
  final clothesColor;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return new Container(
      height: 78,
      constraints: BoxConstraints(minWidth: width),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.45, 1],
          colors: [
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
        children: list
            .map<Widget>((item) => Padding(
                padding: EdgeInsets.only(left: 7.5, right: 7.5),
                child: new IconButton(
                    onPressed: () {
                      changeActiveElement(item);
                    },
                    icon: Transform.scale(
                        scale: 1.8,
                        child: Person(
                          head: partOfAvatar == 1 ? item : head,
                          headColor: headColor,
                          hair: partOfAvatar == 2 && !secondList ? item : hair,
                          bgColor: bgColor,
                          hairColor: hairColor,
                          eyes: partOfAvatar == 3 && !secondList ? item : eyes,
                          mouth: partOfAvatar == 3 && secondList ? item : mouth,
                          clothes: partOfAvatar == 4 ? item : clothes,
                          background: partOfAvatar == 0 ? item : background,
                          faceHair:
                              partOfAvatar == 2 && secondList ? item : faceHair,
                          clothesColor: clothesColor,
                          accessories: partOfAvatar == 5 ? item : accessories,
                          eyesColor: Colors.black,
                          mouthColor: Colors.white,
                        )))))
            .toList(),
      ),
    );
  }
}
