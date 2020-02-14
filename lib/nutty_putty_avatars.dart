library nutty_putty_avatars;

import 'dart:convert';

import 'dart:io';

import 'dart:ui';

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nutty_putty_avatars/constants/palletes.dart';
import 'package:nutty_putty_avatars/styles/index.dart';
import './components/person/index.dart';
import './components/colorChanger/index.dart';
import './components/listOfElements/index.dart';
import './components/partsSwitch/index.dart';

import './services/hexToColor.dart';
import './services/httpRequests.dart';

GlobalKey _globalKey = new GlobalKey();

takeImage() async {
  RenderRepaintBoundary boundary = _globalKey.currentContext.findRenderObject();
  ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  var pngBytes = byteData.buffer.asUint8List();
  String bs64 = base64Encode(pngBytes);

  return pngBytes;
}

class Avatar extends StatefulWidget {
  Avatar({Key key, this.bgColor, this.bgImage}) : super(key: key);
  final bgImage;
  final bgColor;
  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  List parts;
  int partOfAvatar = 0;
  var person;

  @override
  void initState() {
    super.initState();
    getImages();
  }

  getImages() async {
    try {
      var response = await getRequest('/images');

      var decodeResponse = jsonDecode(response);

      var initialPerson = {
        'background': {
          'color': hexToColor(bgPalette[0]),
          'element': decodeResponse['backgrounds'][0]
        },
        'head': {
          'color': hexToColor(headPalette[0]),
          'element': decodeResponse['heads'][0]
        },
        'hair': {
          'color': hexToColor(hairPalette[0]),
          'element': decodeResponse['hairs'][0]
        },
        'eyes': {'element': decodeResponse['eyes'][0]},
        'mouth': {'element': decodeResponse['mouths'][0]},
        'face_hair': {
          'color': hexToColor(hairPalette[0]),
          'element': decodeResponse['face_hairs'][0]
        },
        'clothes': {
          'color': hexToColor(clothPalette[0]),
          'element': decodeResponse['clothes'][0]
        },
        'accessories': {'element': decodeResponse['accessories'][0]}
      };

      setState(() {
        parts = [
          {
            'part': 'background',
            'items': [
              {
                'type': 'part',
                'title': 'BACKGROUND TYPE',
                'parts': decodeResponse['backgrounds']
              },
              {
                'type': 'pallet',
                'title': 'BACKGROUND COLOR',
                'colors': bgPalette
              }
            ]
          },
          {
            'part': 'head',
            'items': [
              {
                'type': 'part',
                'title': 'HEAD TYPE',
                'parts': decodeResponse['heads']
              },
              {'type': 'pallet', 'title': 'SKIN TONE', 'colors': headPalette}
            ]
          },
          {
            'part': 'hair',
            'items': [
              {
                'type': 'part',
                'title': 'HAIR TYPE',
                'parts': decodeResponse['hairs']
              },
              {
                'type': 'part',
                'title': 'FACE HAIR TYPE',
                'secondPart': true,
                'parts': decodeResponse['face_hairs']
              },
              {'type': 'pallet', 'title': 'HAIR COLOR', 'colors': hairPalette}
            ]
          },
          {
            'part': 'face',
            'items': [
              {
                'type': 'part',
                'title': 'EYES TYPE',
                'parts': decodeResponse['eyes']
              },
              {
                'type': 'part',
                'title': 'MOUTH TYPE',
                'secondPart': true,
                'parts': decodeResponse['mouths']
              },
            ]
          },
          {
            'part': 'clothes',
            'items': [
              {
                'type': 'part',
                'title': 'CLOTHES TYPE',
                'parts': decodeResponse['clothes']
              },
              {'type': 'pallet', 'title': 'CLOTH COLOR', 'colors': clothPalette}
            ]
          },
          {
            'part': 'accessories',
            'items': [
              {
                'type': 'part',
                'title': 'ACCESSORIES',
                'parts': decodeResponse['accessories']
              },
            ]
          },
        ];
        person = initialPerson;
      });
    } catch (err) {
      print(err);
    }
  }

  List partsOfAvatarList = [
    'assets/images/partIcons/backgroundIcon.svg',
    'assets/images/partIcons/headIcon.svg',
    'assets/images/partIcons/hairIcon.svg',
    'assets/images/partIcons/emotionIcon.svg',
    'assets/images/partIcons/tshirtIcon.svg',
    'assets/images/partIcons/accessoriesIcon.svg',
  ];

  // part of avatar
  // 0 - background
  // 1 - head
  // 2 - hair
  // 3 - face
  // 4 - clothes
  // 5 - accessories
  changePartOfAvatar(part) {
    setState(() {
      partOfAvatar = part;
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

  changeColor(color, element) {
    if (element == 'hair') {
      person['face_hair']['color'] = color;
      person['hair']['color'] = color;
    } else {
      person[element]['color'] = color;
    }

    setState(() {
      person = person;
    });
  }

  changeActiveElement(item, element, secondList) {
    switch (element) {
      case 'hair':
        if (!secondList) {
          person['hair']['element'] = item;
        } else {
          person['face_hair']['element'] = item;
        }
        break;
      case 'face':
        if (!secondList) {
          person['eyes']['element'] = item;
        } else {
          person['mouth']['element'] = item;
        }

        break;
      default:
        person[element]['element'] = item;
    }

    setState(() {
      person = person;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return parts != null
        ? Container(
            decoration: BoxDecoration(
                color: widget.bgColor != null
                    ? widget.bgColor
                    : hexToColor('#E3EDF7'),
                image: widget.bgImage != null
                    ? DecorationImage(fit: BoxFit.cover, image: widget.bgImage)
                    : null),
            child: Column(children: <Widget>[
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
                            colors: gradient,
                          ),
                          boxShadow: shadow),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Transform.scale(
                            scale: 2,
                            child: RepaintBoundary(
                                key: _globalKey,
                                child: Person(
                                  head: person['head']['element'],
                                  headColor: person['head']['color'],
                                  hair: person['hair']['element'],
                                  accessories: person['accessories']['element'],
                                  faceHair: person['face_hair']['element'],
                                  hairColor: person['hair']['color'],
                                  eyes: person['eyes']['element'],
                                  mouth: person['mouth']['element'],
                                  background: person['background']['element'],
                                  clothes: person['clothes']['element'],
                                  bgColor: person['background']['color'],
                                  clothesColor: person['clothes']['color'],
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
                    Column(
                      children:
                          parts[partOfAvatar]['items'].map<Widget>((item) {
                        return Column(
                          children: <Widget>[
                            renderTitle(item['title']),
                            item['type'] == 'part'
                                ? Padding(
                                    padding:
                                        EdgeInsets.only(top: 15, bottom: 15),
                                    child: ListOfElements(
                                      list: item['parts'],
                                      partOfAvatar: partOfAvatar,
                                      head: person['head']['element'],
                                      headColor: person['head']['color'],
                                      hair: person['hair']['element'],
                                      accessories: person['accessories']
                                          ['element'],
                                      bgColor: person['background']['color'],
                                      faceHair: person['face_hair']['element'],
                                      hairColor: person['hair']['color'],
                                      eyes: person['eyes']['element'],
                                      mouth: person['mouth']['element'],
                                      background: person['background']
                                          ['element'],
                                      clothes: person['clothes']['element'],
                                      clothesColor: person['clothes']['color'],
                                      eyesColor: Colors.black,
                                      mouthColor: Colors.white,
                                      secondList: item['secondPart'] != null,
                                      changeActiveElement: (element) {
                                        changeActiveElement(
                                            element,
                                            parts[partOfAvatar]['part'],
                                            item['secondPart'] != null);
                                      },
                                    ),
                                  )
                                : Container(),
                            item['type'] == 'pallet'
                                ? Padding(
                                    padding: EdgeInsets.only(top: 15),
                                    child: ColorChanger(
                                        color:
                                            person[parts[partOfAvatar]['part']]
                                                ['color'],
                                        onChanged: (color) {
                                          changeColor(color,
                                              parts[partOfAvatar]['part']);
                                        },
                                        palette: item['colors']),
                                  )
                                : Container()
                          ],
                        );
                      }).toList(),
                    )
                  ]))
            ]))
        : new CircularProgressIndicator(
            backgroundColor: Colors.transparent,
            valueColor:
                new AlwaysStoppedAnimation<Color>(hexToColor('#f44336')));
  }
}
