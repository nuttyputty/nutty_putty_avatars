library nutty_putty_avatars;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/utils.dart';
// import 'package:flutter_colorpicker/utils.dart';
import 'package:nutty_putty_avatars/constants/palletes.dart';
// import "package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart";
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import './components/person/index.dart';
import './components/colorChanger/index.dart';
import './components/listOfElements/index.dart';
import './components/partsSwitch/index.dart';
// import './components/slider.dart';

import './services/hexToColor.dart';
import './services/httpRequests.dart';

import './constants/arraysOfParts.dart';
import './components/test.dart';

class Avatar extends StatefulWidget {
  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  GlobalKey _globalKey = new GlobalKey();
  static Color headColor = hexToColor('#F5E3C3');
  static Color bgColor = hexToColor('#FFFFFF');
  static Color hairColor = hexToColor('#32302E');
  static Color clothesColor = hexToColor('#32302E');
  int partOfAvatar = 0;
  List<String> palette = bgPalette;

  List faceHairs;
  List heads;
  List hairs;
  List mouths;
  List eyes;
  List accessories;
  List backgrounds;
  List clothes;

  @override
  void initState() {
    super.initState();
    getImages();
  }

  getImages() async {
    try {
      var response = await getRequest('/images');

      var decodeResponse = jsonDecode(response);

      setState(() {
        faceHairs = decodeResponse['face_hairs'];
        heads = decodeResponse['heads'];
        hairs = decodeResponse['hairs'];
        mouths = decodeResponse['mouths'];
        eyes = decodeResponse['eyes'];
        clothes = decodeResponse['clothes'];
        accessories = decodeResponse['accessories'];
        backgrounds = decodeResponse['backgrounds'];
        activeBackground = decodeResponse['backgrounds'][0];
        activeEyes = decodeResponse['eyes'][0];
        activeMouth = decodeResponse['mouths'][0];
        activeHead = decodeResponse['heads'][0];
        activeHair = decodeResponse['hairs'][0];
        activeFaceHair = decodeResponse['face_hairs'][0];
        activeClothes = decodeResponse['clothes'][0];
        activeAccessories = decodeResponse['accessories'][0];
      });
    } catch (err) {
      print(err);
    }
  }

  Object activeHead;
  Object activeHair;
  Object activeFaceHair;

  Object activeEyes;
  Object activeMouth;
  Object activeClothes;
  Object activeAccessories;
  Object activeBackground;
  List partsOfAvatarList = [
    {
      'partOfAvatar': 0,
      'image': 'assets/images/partIcons/backgroundIcon.svg',
      'color': hexToColor('#8D9CB3')
    },
    {
      'partOfAvatar': 1,
      'image': 'assets/images/partIcons/headIcon.svg',
      'color': hexToColor('#8D9CB3')
    },
    {
      'partOfAvatar': 2,
      'image': 'assets/images/partIcons/hairIcon.svg',
      'color': hexToColor('#8D9CB3')
    },
    {
      'partOfAvatar': 3,
      'image': 'assets/images/partIcons/emotionIcon.svg',
      'color': hexToColor('#8D9CB3')
    },
    {
      'partOfAvatar': 4,
      'image': 'assets/images/partIcons/tshirtIcon.svg',
      'color': hexToColor('#8D9CB3')
    },
    {
      'partOfAvatar': 5,
      'image': 'assets/images/partIcons/accessoriesIcon.svg',
      'color': hexToColor('#8D9CB3')
    },
  ];

  changePartOfAvatar(part) {
    setState(() {
      partOfAvatar = part;
      palette = part == 0
          ? bgPalette
          : part == 1 ? headPalette : part == 2 ? hairPalette : clothPalette;
    });
  }

  renderTitle(text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: new Text(
        text.toUpperCase(),
        style: TextStyle(
          color: hexToColor('#8D9CB3'),
          fontFamily: 'Roboto',
          fontSize: 14,
        ),
      ),
    );
  }

  fung(hue, light) {
    return HSLColor.fromAHSL(1, hue, 1, light);
  }

  // part of avatar
  // 0 - head
  // 1 - hair
  // 2 - clothes
  changeColor(color) {
    setState(() {
      switch (partOfAvatar) {
        case 0:
          bgColor = color;
          break;
        case 1:
          print('asd');
          headColor = color;
          break;
        case 2:
          hairColor = color;
          break;
        case 4:
          clothesColor = color;
          break;
      }
    });
  }

  changeActiveElement(item, secondList) {
    print('[ITEM] $item');
    item = item.toColor();
    setState(() {
      switch (partOfAvatar) {
        case 0:
          activeBackground = item;
          break;
        case 1:
          activeHead = item;
          break;
        case 2:
          if (!secondList) {
            activeHair = item;
          } else {
            activeFaceHair = item;
          }
          break;
        case 3:
          if (!secondList) {
            activeEyes = item;
          } else {
            activeMouth = item;
          }
          break;
        case 4:
          activeClothes = item;
          break;
        case 5:
          activeAccessories = item;
          break;
      }
    });
  }

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    var title1 = partOfAvatar == 0
        ? 'Background Type'
        : partOfAvatar == 1
            ? 'Head type'
            : partOfAvatar == 2
                ? 'Hair type'
                : partOfAvatar == 3
                    ? 'Eyes type'
                    : partOfAvatar == 4 ? 'clothes Type' : 'accessories';
    var title2 = partOfAvatar == 2
        ? 'Face Hair type'
        : partOfAvatar == 3 ? 'mouth type' : '';
    var title3 = partOfAvatar == 0
        ? 'Background color'
        : partOfAvatar == 1
            ? 'Skin Tone'
            : partOfAvatar == 2
                ? 'hair color'
                : partOfAvatar == 3
                    ? 'Eyes type'
                    : partOfAvatar == 4 ? 'cloth color' : '';

    return new Scaffold(
        backgroundColor: hexToColor('#E3EDF7'),
        body: accessories != null &&
                clothes != null &&
                eyes != null &&
                hairs != null &&
                mouths != null &&
                heads != null &&
                faceHairs != null &&
                eyes != null
            ? ListView(
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  new Container(
                      padding: EdgeInsets.only(left: 14, right: 14),
                      child: new Column(children: <Widget>[
                        height > 767
                            ? Padding(
                                padding: EdgeInsets.only(top: 60, bottom: 28),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: new Text(
                                    'AVATAR\nSETTINGS',
                                    style: TextStyle(
                                      color: hexToColor('#31456A'),
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                height: 40,
                              ),
                        Container(
                          alignment: Alignment.center,
                          width: 142,
                          height: 142,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(38),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.45, 1],
                              colors: [
                                hexToColor('#E3EDF7').withOpacity(1),
                                Color.fromRGBO(255, 255, 255, 0.7)
                              ],
                            ),
                            boxShadow: <BoxShadow>[
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
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Transform.scale(
                                scale: 2,
                                child: RepaintBoundary(
                                    key: _globalKey,
                                    child: Person(
                                      head: activeHead,
                                      headColor: headColor,
                                      hair: activeHair,
                                      accessories: activeAccessories,
                                      faceHair: activeFaceHair,
                                      hairColor: hairColor,
                                      eyes: activeEyes,
                                      mouth: activeMouth,
                                      background: activeBackground,
                                      clothes: activeClothes,
                                      clothesColor: clothesColor,
                                      eyesColor: Colors.black,
                                      mouthColor: Colors.white,
                                    ))),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: height > 667 ? 32 : 25,
                              bottom: height > 667 ? 20 : 15),
                          child: PartsSwitch(
                            changePart: changePartOfAvatar,
                            parts: partsOfAvatarList,
                            activePart: partOfAvatar,
                          ),
                        ),
                        renderTitle(title1),
                        Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: ListOfElements(
                            list: partOfAvatar == 0
                                ? backgrounds
                                : partOfAvatar == 1
                                    ? heads
                                    : partOfAvatar == 2
                                        ? hairs
                                        : partOfAvatar == 3
                                            ? eyes
                                            : partOfAvatar == 4
                                                ? clothes
                                                : partOfAvatar == 5
                                                    ? accessories
                                                    : [],
                            partOfAvatar: partOfAvatar,
                            head: activeHead,
                            faceHair: activeFaceHair,
                            accessories: activeAccessories,
                            headColor: headColor,
                            hair: activeHair,
                            hairColor: hairColor,
                            eyes: activeEyes,
                            mouth: activeMouth,
                            background: activeBackground,
                            clothes: activeClothes,
                            clothesColor: clothesColor,
                            eyesColor: Colors.black,
                            mouthColor: Colors.white,
                            secondList: false,
                            changeActiveElement: (item) {
                              changeActiveElement(item, false);
                            },
                            activeElementColor: headColor,
                          ),
                        ),
                        partOfAvatar == 2 || partOfAvatar == 3
                            ? new Column(
                                children: <Widget>[
                                  renderTitle(title2),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 15, bottom: 15),
                                    child: ListOfElements(
                                      list: partOfAvatar == 2
                                          ? faceHairs
                                          : partOfAvatar == 3 ? mouths : [],
                                      partOfAvatar: partOfAvatar,
                                      head: activeHead,
                                      headColor: headColor,
                                      hair: activeHair,
                                      hairColor: hairColor,
                                      secondList: true,
                                      eyes: activeEyes,
                                      mouth: activeMouth,
                                      faceHair: activeFaceHair,
                                      clothes: activeClothes,
                                      background: activeBackground,
                                      clothesColor: clothesColor,
                                      accessories: activeAccessories,
                                      eyesColor: Colors.black,
                                      mouthColor: Colors.white,
                                      changeActiveElement: (item) {
                                        changeActiveElement(item, true);
                                      },
                                      activeElementColor: headColor,
                                    ),
                                  ),
                                ],
                              )
                            : new Container(),
                        partOfAvatar != 3 && partOfAvatar != 5
                            ? new Column(
                                children: <Widget>[
                                  renderTitle(title3),
                                  Padding(
                                    padding: EdgeInsets.only(top: 15),
                                    child: ColorChanger(
                                        color: partOfAvatar == 0
                                            ? bgColor
                                            : partOfAvatar == 1
                                                ? headColor
                                                : partOfAvatar == 2
                                                    ? hairColor
                                                    : clothesColor,
                                        onChanged: (color) {
                                          changeColor(color);
                                        },
                                        palette: palette),
                                  ),
                                ],
                              )
                            : new Container(),
                      ]))
                ],
              )
            : new CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                valueColor:
                    new AlwaysStoppedAnimation<Color>(hexToColor('#f44336'))));
  }
}
