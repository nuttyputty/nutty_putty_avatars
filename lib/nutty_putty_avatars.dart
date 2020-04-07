library nutty_putty_avatars;

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:nutty_putty_avatars/constants/palletes.dart';
import 'package:nutty_putty_avatars/services/inAppPurchase.dart';
import 'package:nutty_putty_avatars/styles/index.dart';

import './components/person/index.dart';
import './components/colorChanger/index.dart';
import './components/listOfElements/index.dart';
import './components/partsSwitch/index.dart';
import './components/popUp.dart';

import './services/hexToColor.dart';
import './services/httpRequests.dart';

class Avatar extends StatefulWidget {
  Avatar(
      {Key key,
      this.elementsColor,
      this.bgColor,
      this.restoreCb,
      this.partBorderColor,
      this.bgImage,
      this.avatarBg,
      this.iosList,
      this.androidList,
      this.isStaging,
      this.initialAvatar})
      : super(key: key);
  final bgImage;
  final bgColor;
  final elementsColor;
  final avatarBg;
  final iosList;
  final isStaging;
  final restoreCb;
  final androidList;
  static GlobalKey _globalKey = new GlobalKey<AvatarState>();
  final initialAvatar;
  final partBorderColor;
  @override
  AvatarState createState() => AvatarState();
}

class AvatarState extends State<Avatar> {
  List parts;
  int partOfAvatar = 0;
  static var person;
  List hatHairs;
  List hairs;
  bool isHatActive = false;
  bool showSlider = true;
  bool fullVersion = false;
  bool loader = false;
  bool popup = false;
  @override
  void initState() {
    super.initState();
    getImages();
    if (widget.iosList != null && widget.androidList != null) {
      initPlatformState(widget.iosList, widget.androidList, () {
        setState(() {
          fullVersion = true;
        });
        showPopup(false);
        toggleLoader(false);
      }, () {
        toggleLoader(false);
      }).whenComplete(() async {
        var purchased = await getPurchases();

        var data = await hasPurchased(
            Platform.isIOS ? widget.iosList[0] : widget.androidList[0],
            purchased);

        setState(() {
          fullVersion = data != null;
        });
      });
    }
  }

  static getParts() {
    return person;
  }

  static takeImage() async {
    RenderRepaintBoundary boundary =
        Avatar._globalKey.currentContext.findRenderObject();

    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    var pngBytes = byteData.buffer.asUint8List();

    return {
      'parts': person,
      'image': pngBytes,
    };
  }

  getImages() async {
    try {
      var response = await getRequest('/images', widget.isStaging);

      var decodeResponse = jsonDecode(response);

      var initialPerson = {
        'background': {
          'color': hexToColor(bgPalette[5]),
          'element': decodeResponse['backgrounds'][0]
        },
        'head': {
          'color': hexToColor(headPalette[1]),
          'element': decodeResponse['heads'][0]
        },
        'hair': {
          'color': hexToColor(hairPalette[0]),
          'element': decodeResponse['hairs'][0]
        },
        'hats': {'element': decodeResponse['hats'][0]},
        'eyes': {
          'element': decodeResponse['eyes'][0],
          'color': hexToColor(eyesPalette[0])
        },
        'noses': {'element': decodeResponse['noses'][0]},
        'mouth': {'element': decodeResponse['mouths'][0]},
        'face_hairs': {
          'color': hexToColor(hairPalette[0]),
          'element': decodeResponse['face_hairs'][0]
        },
        'clothes': {
          'color': hexToColor(clothPalette[0]),
          'element': decodeResponse['clothes'][0]
        },
        'accessories': {'element': decodeResponse['accessories'][0]},
        'eyebrows': {'element': decodeResponse['eyebrows'][0]}
      };

      var initAvatar = widget.initialAvatar;
      if (widget.initialAvatar != null) {
        initialPerson.forEach((key, val) {
          if (!initAvatar.containsKey(key)) {
            initAvatar[key] = val;
          }
        });
      }

      setState(() {
        hatHairs = decodeResponse['hat_hairs'];
        hairs = decodeResponse['hairs'];
        parts = [
          {
            'part': 0,
            'partImage': 'assets/images/partIcons/backgroundIcon.svg',
            'items': [
              {
                'type': 'part',
                'title': 'BACKGROUND TYPE',
                'subpart': 'background',
                'parts': decodeResponse['backgrounds']
              },
              {
                'type': 'pallet',
                'subpart': 'background',
                'title': 'BACKGROUND COLOR',
                'colors': bgPalette
              }
            ]
          },
          {
            'part': 1,
            'partImage': 'assets/images/partIcons/headIcon.svg',
            'items': [
              {
                'type': 'part',
                'title': 'HEAD TYPE',
                'subpart': 'head',
                'parts': decodeResponse['heads']
              },
              {
                'type': 'pallet',
                'subpart': 'head',
                'title': 'SKIN TONE',
                'colors': headPalette
              }
            ]
          },
          {
            'part': 2,
            'partImage': 'assets/images/partIcons/hairIcon.svg',
            'items': [
              {
                'type': 'part',
                'title': 'HAIR TYPE',
                'subpart': 'hair',
                'parts': widget.initialAvatar != null &&
                        widget.initialAvatar['hats']['element']['image'] != null
                    ? decodeResponse['hat_hairs']
                    : decodeResponse['hairs']
              },
              {
                'type': 'part',
                'title': 'FACE HAIR TYPE',
                'subpart': 'face_hairs',
                'parts': decodeResponse['face_hairs']
              },
              {
                'type': 'pallet',
                'subpart': 'face_hairs',
                'title': 'HAIR COLOR',
                'colors': hairPalette
              }
            ]
          },
          {
            'part': 3,
            'partImage': 'assets/images/partIcons/emotionIcon.svg',
            'items': [
              {
                'type': 'part',
                'title': 'EYEBROWS & EYES',
                'subpart': 'eyebrows',
                'parts': decodeResponse['eyebrows']
              },
              {
                'type': 'part',
                'title': '',
                'subpart': 'eyes',
                'parts': decodeResponse['eyes']
              },
              {
                'type': 'pallet',
                'subpart': 'eyes',
                'title': 'EYES COLOR',
                'slider': false,
                'colors': eyesPalette
              },
              {
                'type': 'part',
                'title': 'NOSES & MOUTH',
                'subpart': 'noses',
                'parts': decodeResponse['noses']
              },
              {
                'type': 'part',
                'title': '',
                'subpart': 'mouth',
                'parts': decodeResponse['mouths']
              },
            ]
          },
          {
            'part': 4,
            'partImage': 'assets/images/partIcons/tshirtIcon.svg',
            'items': [
              {
                'type': 'part',
                'title': 'CLOTHES TYPE',
                'subpart': 'clothes',
                'parts': decodeResponse['clothes']
              },
              {
                'type': 'pallet',
                'subpart': 'clothes',
                'title': 'CLOTH COLOR',
                'colors': clothPalette
              }
            ]
          },
          {
            'part': 5,
            'partImage': 'assets/images/partIcons/accessoriesIcon.svg',
            'items': [
              {
                'type': 'part',
                'title': 'HATS',
                'subpart': 'hats',
                'parts': decodeResponse['hats']
              },
              {
                'type': 'part',
                'title': 'ACCESSORIES',
                'subpart': 'accessories',
                'parts': decodeResponse['accessories']
              },
            ]
          },
        ];
        person = widget.initialAvatar == null ? initialPerson : initAvatar;
      });
    } catch (err) {
      print(err);
    }
  }

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
    return Padding(
        padding: EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: new Text(
            text.toUpperCase(),
            style: TextStyle(
              color: hexToColor('#8D9CB3'),
              fontFamily: 'Roboto',
              fontSize: 14,
            ),
          ),
        ));
  }

  changeColor(color, element) {
    person[element]['color'] = color;
    setState(() {
      person = person;
    });
  }

  showPopup(data) {
    setState(() {
      popup = data;
    });
  }

  toggleLoader(data) {
    setState(() {
      loader = data;
    });
  }

  changeActiveElement(item, element) {
    if (item['free'] || fullVersion) {
      if (element == 'hats') {
        bool isHat = item['image'] != null;
        var a = parts.map((item) {
          if (item['part'] == 2) {
            item['items'][0]['parts'] = isHat ? hatHairs : hairs;
            return item;
          }
          return item;
        }).toList();

        var index = hatHairs.indexWhere(
            (item) => person['hair']['element']['id'] == item['id']);

        if (index == -1) {
          index = hairs.indexWhere(
              (item) => person['hair']['element']['id'] == item['id']);
        }

        setState(() {
          person['hair']['element'] = isHat ? hatHairs[index] : hairs[index];
          parts = a;
        });
      }

      setState(() {
        person[element]['element'] = item;
        showSlider = item['free'] && element == 'background';
      });
    } else {
      // showPopUp(context, loader, (data) {
      //   toggleLoader(data);
      // });
      showPopup(true);
    }
  }

  var a = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.45, 1],
    colors: [hexToColor('#2A2A2A'), hexToColor('#2A2A2A')],
  );

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    var active;
    if (parts != null) {
      active = parts.firstWhere((item) => item['part'] == partOfAvatar);
    }

    return parts != null
        ? Stack(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      color: widget.bgColor != null
                          ? widget.bgColor
                          : hexToColor('#E3EDF7'),
                      image: widget.bgImage != null
                          ? DecorationImage(
                              fit: BoxFit.cover, image: widget.bgImage)
                          : null),
                  child: Column(children: <Widget>[
                    new Container(
                        padding: EdgeInsets.only(left: 14, right: 14),
                        child: new Column(children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(left: 80),
                                    width: 142,
                                    height: 142,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(38),
                                        image: widget.avatarBg != null
                                            ? DecorationImage(
                                                image: widget.avatarBg,
                                                fit: BoxFit.contain)
                                            : null,
                                        gradient: widget.avatarBg == null
                                            ? LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                stops: [0.45, 1],
                                                colors: widget.elementsColor !=
                                                        null
                                                    ? [
                                                        widget.elementsColor,
                                                        widget.elementsColor
                                                      ]
                                                    : gradient,
                                              )
                                            : null,
                                        boxShadow:
                                            widget.elementsColor != null ||
                                                    widget.avatarBg != null
                                                ? null
                                                : shadow),
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 20),
                                      child: Transform.scale(
                                        scale: 2,
                                        child: RepaintBoundary(
                                          key: Avatar._globalKey,
                                          child: Person(
                                            isFree: true,
                                            head: person['head']['element'],
                                            hats: person['hats']['element'],
                                            headColor: person['head']['color'],
                                            eyebrows: person['eyebrows']
                                                ['element'],
                                            hair: person['hair']['element'],
                                            accessories: person['accessories']
                                                ['element'],
                                            faceHair: person['face_hairs']
                                                ['element'],
                                            hairColor: person['face_hairs']
                                                ['color'],
                                            noses: person['noses']['element'],
                                            eyes: person['eyes']['element'],
                                            mouth: person['mouth']['element'],
                                            background: person['background']
                                                ['element'],
                                            clothes: person['clothes']
                                                ['element'],
                                            bgColor: person['background']
                                                ['color'],
                                            clothesColor: person['clothes']
                                                ['color'],
                                            eyesColor: person['eyes']['color'],
                                            mouthColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 88,
                                child: FlatButton(
                                  child: Text(
                                    'Restore\npurchase',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: hexToColor('#8D9CB3')),
                                  ),
                                  onPressed: () {
                                    getPurchases(() {
                                      if (widget.restoreCb != null) {
                                        widget.restoreCb();
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: height > 667 ? 32 : 25,
                                bottom: height > 667 ? 20 : 15),
                            child: PartsSwitch(
                                changePart: changePartOfAvatar,
                                parts: parts,
                                partBorder: widget.partBorderColor,
                                activePart: partOfAvatar,
                                color: widget.elementsColor),
                          ),
                          Column(
                            children: active['items'].map<Widget>((item) {
                              bool show = item['subpart'] != 'background' ||
                                  showSlider ||
                                  item['title'] == 'BACKGROUND TYPE';
                              return Column(
                                children: <Widget>[
                                  item['title'] != ''
                                      ? show
                                          ? renderTitle(item['title'])
                                          : Container()
                                      : Container(),
                                  item['type'] == 'part'
                                      ? ListOfElements(
                                          list: item,
                                          partOfAvatar: partOfAvatar,
                                          head: person['head']['element'],
                                          hats: person['hats']['element'],
                                          headColor: person['head']['color'],
                                          hair: person['hair']['element'],
                                          eyebrows: person['eyebrows']
                                              ['element'],
                                          accessories: person['accessories']
                                              ['element'],
                                          bgColor: person['background']
                                              ['color'],
                                          faceHair: person['face_hairs']
                                              ['element'],
                                          hairColor: person['face_hairs']
                                              ['color'],
                                          eyes: person['eyes']['element'],
                                          mouth: person['mouth']['element'],
                                          noses: person['noses']['element'],
                                          background: person['background']
                                              ['element'],
                                          clothes: person['clothes']['element'],
                                          clothesColor: person['clothes']
                                              ['color'],
                                          eyesColor: person['eyes']['color'],
                                          mouthColor: Colors.white,
                                          hairs: hairs,
                                          hatHairs: hatHairs,
                                          changeActiveElement: (element) {
                                            changeActiveElement(
                                              element,
                                              item['subpart'],
                                            );
                                          },
                                          fullVersion: fullVersion,
                                          person: person,
                                          color: widget.elementsColor)
                                      : Container(),
                                  item['type'] == 'pallet'
                                      ? show
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: ColorChanger(
                                                  bg: widget.elementsColor,
                                                  color: person[item['subpart']]
                                                      ['color'],
                                                  onChanged: (color) {
                                                    changeColor(
                                                        color, item['subpart']);
                                                  },
                                                  displaySlider:
                                                      item['slider'] == null,
                                                  palette: item['colors']),
                                            )
                                          : Container()
                                      : Container()
                                ],
                              );
                            }).toList(),
                          )
                        ]))
                  ])),
              popup
                  ? UpgradePopup(
                      loader: loader,
                      changeLoader: (data) {
                        toggleLoader(data);
                      },
                      closePopup: () {
                        showPopup(false);
                        toggleLoader(false);
                      },
                    )
                  : SizedBox()
            ],
          )
        : new Container(
            width: 20,
            height: 40,
            alignment: Alignment.center,
            child: new CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(hexToColor('#f44336')),
            ),
          );
  }
}
