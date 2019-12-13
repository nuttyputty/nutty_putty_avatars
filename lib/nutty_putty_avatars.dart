library nutty_putty_avatars;

import 'package:flutter/material.dart';

import './components/person/index.dart';
import './components/colorChanger/index.dart';
import './components/listOfElements/index.dart';
import './components/partsSwitch/index.dart';

class Avatar extends StatefulWidget {
  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  GlobalKey _globalKey = new GlobalKey();
  static HSVColor headColor = new HSVColor.fromColor(Colors.blue);
  static HSVColor hairColor = new HSVColor.fromColor(Colors.brown);
  static HSVColor clothesColor = new HSVColor.fromColor(Colors.black);
  int partOfAvatar = 0;

  Object activeHead = {
    'image': 'assets/images/heads/HeadShapes_Head_type_1.svg',
    'shadow': 'assets/images/heads/HeadShapes_Head_shadow_1.svg'
  };

  Object activeHair = {
    'image': 'assets/images/person/Hair.svg',
    'shadow': 'assets/images/person/Hair Shadow.svg'
  };

  Object activeEyes = {'image': 'assets/images/person/Eyes.svg'};

  Object activeMouth = {'image': 'assets/images/person/Mouth.svg'};

  Object activeClothes = {'image': 'assets/images/person/Clothes.svg'};

  List<String> hairs = [
    'assets/images/Hair.svg',
    'assets/images/Hair.svg',
    'assets/images/Hair.svg',
    'assets/images/Hair.svg',
    'assets/images/Hair.svg',
    'assets/images/Hair.svg',
  ];

  List<String> emotion = [
    'assets/images/Emotion.svg',
    'assets/images/Emotion.svg',
    'assets/images/Emotion.svg',
    'assets/images/Emotion.svg',
    'assets/images/Emotion.svg',
    'assets/images/Emotion.svg',
  ];

  List<String> clothes = [
    'assets/images/Clothes.svg',
    'assets/images/Clothes.svg',
    'assets/images/Clothes.svg',
    'assets/images/Clothes.svg',
    'assets/images/Clothes.svg',
    'assets/images/Clothes.svg',
  ];

  List<Object> heads = [
    {
      'image': 'assets/images/heads/HeadShapes_Head_type_1.svg',
      'shadow': 'assets/images/heads/HeadShapes_Head_shadow_1.svg'
    },
    {
      'image': 'assets/images/heads/HeadShapes_Head_type_2.svg',
      'shadow': 'assets/images/heads/HeadShapes_Head_shadow_2.svg'
    },
    {
      'image': 'assets/images/heads/HeadShapes_Head_type_3.svg',
      'shadow': 'assets/images/heads/HeadShapes_Head_shadow_3.svg'
    },
    {
      'image': 'assets/images/heads/HeadShapes_Head_type_4.svg',
      'shadow': 'assets/images/heads/HeadShapes_Head_shadow_4.svg'
    },
    {
      'image': 'assets/images/heads/HeadShapes_Head_type_5.svg',
      'shadow': 'assets/images/heads/HeadShapes_Head_shadow_5.svg'
    },
    {
      'image': 'assets/images/heads/HeadShapes_Head_type_6.svg',
      'shadow': 'assets/images/heads/HeadShapes_Head_shadow_6.svg'
    }
  ];

  List partsOfAvatarList = [
    {
      'partOfAvatar': 0,
      'image': 'assets/images/heads/HeadShapes_Head_type_1.svg',
      'color': headColor.toColor()
    },
    {
      'partOfAvatar': 1,
      'image': 'assets/images/person/Hair.svg',
      'color': hairColor.toColor()
    },
    {
      'partOfAvatar': 2,
      'image': 'assets/images/person/Clothes.svg',
      'color': clothesColor.toColor()
    },
  ];

  changePartOfAvatar(part) {
    setState(() {
      partOfAvatar = part;
    });
  }

  // part of avatar
  // 0 - head
  // 1 - hair
  // 2 - clothes
  changeColor(value) {
    setState(() {
      switch (partOfAvatar) {
        case 0:
          headColor = value;
          break;
        case 1:
          hairColor = value;
          break;
        case 2:
          clothesColor = value;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Padding(
              padding: EdgeInsets.only(bottom: 90),
              child: Transform.scale(
                  scale: 3,
                  child: RepaintBoundary(
                      key: _globalKey,
                      child: Person(
                        head: activeHead,
                        headColor: headColor,
                        hair: activeHair,
                        hairColor: hairColor,
                        eyes: activeEyes,
                        mouth: activeMouth,
                        clothes: activeClothes,
                        clothesColor: clothesColor,
                        eyesColor: Colors.black,
                        mouthColor: Colors.white,
                      )))),
          ListOfElements(
            list: heads,
            changeActiveElement: (item) {
              setState(() {
                activeHead = item;
              });
            },
            activeElementColor: headColor,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: PartsSwitch(
              changePart: changePartOfAvatar,
              parts: partsOfAvatarList,
            ),
          ),
          ColorChanger(
              color: partOfAvatar == 0
                  ? headColor
                  : partOfAvatar == 1 ? hairColor : clothesColor,
              onChanged: (value) {
                changeColor(
                  value,
                );
              }),
        ]));
  }
}
