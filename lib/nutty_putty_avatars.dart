library nutty_putty_avatars;

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutty_putty_avatars/blocks/avatars/avatar.dart';
import 'package:nutty_putty_avatars/blocks/person/person.dart';
import 'package:nutty_putty_avatars/components/creater_avatar_part.dart';
import 'package:nutty_putty_avatars/components/person/index.dart';

import 'package:nutty_putty_avatars/constants/palletes.dart';
import 'package:nutty_putty_avatars/models/part.dart';
import 'package:nutty_putty_avatars/models/person.dart' as model;
import 'package:nutty_putty_avatars/models/avatar.dart' as avatarModel;
import 'package:nutty_putty_avatars/services/inAppPurchase.dart';

import 'package:nutty_putty_avatars/styles/index.dart';

// import './components/person/index.dart';
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
      this.textColor,
      this.isStaging,
      this.activePartColor,
      this.partColor,
      this.initialAvatar})
      : super(key: key);
  final bgImage;
  final bgColor;
  final elementsColor;
  final avatarBg;
  final Color activePartColor;
  final Color partColor;
  final textColor;
  final iosList;
  final isStaging;
  final restoreCb;
  final androidList;
  static GlobalKey _globalKey = new GlobalKey<AvatarStatea>();
  final model.Person initialAvatar;
  final partBorderColor;
  @override
  AvatarStatea createState() => AvatarStatea();
}

class AvatarStatea extends State<Avatar> {
  // List<AvatarPart> parts;
  int partOfAvatar = 0;
  static model.Person person;
  List<avatarModel.Hairs> hairs;
  List<avatarModel.HatHairs> hatHairs;
  bool isHatActive = false;
  bool showSlider = true;
  bool fullVersion = false;
  bool loader = false;

  @override
  void initState() {
    super.initState();
    // getImages();
    // if (widget.iosList != null && widget.androidList != null) {
    //   initPlatformState(widget.iosList, widget.androidList, () {
    //     setState(() {
    //       fullVersion = true;
    //     });
    //     toggleLoader(false);
    //     Navigator.of(context, rootNavigator: true).pop('dialog');
    //   }, (e) {
    //     showToast('$e');
    //     Navigator.of(context, rootNavigator: true).pop('dialog');
    //     toggleLoader(false);
    //   }).whenComplete(() async {
    //     var purchased = await getPurchases();

    //     var data = await hasPurchased(
    //         Platform.isIOS ? widget.iosList[0] : widget.androidList[0],
    //         purchased);

    //     setState(() {
    //       fullVersion = data != null;
    //     });
    //   });
    // }

    _avatarBloc = BlocProvider.of<AvatarBloc>(context);
    _personBloc = BlocProvider.of<PersonBloc>(context);
    _avatarBloc.add(GetAvatars(isStaging: widget.isStaging ?? false));
    // getImages();
  }

  static model.Person getParts() {
    return person;
  }

  static Future<Uint8List> takeImage() async {
    RenderRepaintBoundary boundary =
        Avatar._globalKey.currentContext.findRenderObject();

    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    Uint8List pngBytes = byteData.buffer.asUint8List();

    return pngBytes;
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
              color: widget.textColor != null
                  ? widget.textColor
                  : hexToColor('#8D9CB3'),
              fontFamily: 'Roboto',
              fontSize: 14,
            ),
          ),
        ));
  }

  changeColor(color, element) {
    color = colorToHex(color);
    switch (element) {
      case 'background':
        person.background.color = color;

        break;
      case 'accessories':
        person.accessories.color = color;
        break;
      case 'face_hairs':
        person.faceHairs.color = color;
        break;
      case 'clothes':
        person.clothes.color = color;
        break;
      case 'eyebrows':
        person.eyebrows.color = color;
        break;
      case 'eyes':
        person.eyes.color = color;
        break;
      case 'hair':
        person.hair.color = color;
        break;
      case 'hats':
        person.hats.color = color;
        break;
      case 'head':
        person.head.color = color;
        break;
      case 'mouth':
        person.mouth.color = color;
        break;
    }
    setState(() {
      person = person;
    });
  }

  toggleLoader(data) {
    setState(() {
      loader = data;
    });
  }

  changeActiveElement(model.Element item, element) {
    if (item.free || fullVersion) {
      if (element == 'hats') {
        bool isHat = item.image != null;
        var a = partsData.map((item) {
          if (item.part == 2) {
            item.items[0].parts = isHat
                ? hatHairs.map((element) {
                    return model.Element.fromJson(element.toJson());
                  }).toList()
                : hairs.map((element) {
                    return model.Element.fromJson(element.toJson());
                  }).toList();
            return item;
          }
          return item;
        }).toList();

        var index =
            hatHairs.indexWhere((item) => person.hair.element.id == item.id);

        if (index == -1) {
          index = hairs.indexWhere((item) => person.hair.element.id == item.id);
        }

        setState(() {
          person.hair.element = isHat
              ? model.Element.fromJson(hatHairs[index].toJson())
              : model.Element.fromJson(hairs[index].toJson());
          partsData = a;
        });
      }

      switch (element) {
        case 'background':
          setState(() {
            person.background.element = item;
          });

          break;
        case 'accessories':
          setState(() {
            person.accessories.element = item;
          });

          break;
        case 'face_hairs':
          setState(() {
            person.faceHairs.element = item;
          });

          break;
        case 'clothes':
          setState(() {
            person.clothes.element = item;
          });

          break;
        case 'eyebrows':
          setState(() {
            person.eyebrows.element = item;
          });

          break;
        case 'eyes':
          setState(() {
            person.eyes.element = item;
          });

          break;
        case 'hair':
          setState(() {
            person.hair.element = item;
          });

          break;
        case 'hats':
          setState(() {
            person.hats.element = item;
          });

          break;
        case 'head':
          setState(() {
            person.head.element = item;
          });

          break;
        case 'mouth':
          setState(() {
            person.mouth.element = item;
          });

          break;
      }

      // setState(() {
      //   person[element]['element'] = item;
      //   showSlider = item['free'] && element == 'background';
      // });
    } else {
      toggleLoader(false);
      showPopUp(context, loader, (data) {
        toggleLoader(data);
      }, Platform.isIOS ? widget.iosList[0] : widget.androidList[0]);
    }
  }

  Map<String, dynamic> generateInitalPerson(avatarModel.Avatar avatars) {
    return {
      'background': {
        'color': bgPalette[5],
        'element': avatars.backgrounds[0].toJson()
      },
      'head': {'color': headPalette[1], 'element': avatars.heads[0].toJson()},
      'hair': {'color': hairPalette[0], 'element': avatars.hairs[0].toJson()},
      'hats': {'element': avatars.hats[0].toJson()},
      'eyes': {'element': avatars.eyes[0].toJson(), 'color': eyesPalette[0]},
      'noses': {'element': avatars.noses[0].toJson()},
      'mouth': {'element': avatars.mouths[0].toJson()},
      'face_hairs': {
        'color': hairPalette[0],
        'element': avatars.faceHairs[0].toJson()
      },
      'clothes': {
        'color': clothPalette[0],
        'element': avatars.clothes[0].toJson()
      },
      'accessories': {'element': avatars.accessories[0].toJson()},
      'eyebrows': {'element': avatars.eyebrows[0].toJson()}
    };
  }

  List<AvatarPart> generatePartsList(avatarModel.Avatar data) {
    setState(() {
      hairs = data.hairs;
      hatHairs = data.hatHairs;
    });

    var array = [
      {
        'part': 0,
        'partImage': 'assets/images/partIcons/backgroundIcon.svg',
        'items': [
          {
            'type': 'part',
            'title': 'BACKGROUND TYPE',
            'subpart': 'background',
            'parts': data.backgrounds.map((e) => e.toJson()).toList()
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
            'parts': data.heads.map((e) => e.toJson()).toList()
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
                    widget.initialAvatar.hats.element.image != null
                ? data.hatHairs.map((e) => e.toJson()).toList()
                : data.hairs.map((e) => e.toJson()).toList()
          },
          {
            'type': 'part',
            'title': 'FACE HAIR TYPE',
            'subpart': 'face_hairs',
            'parts': data.faceHairs.map((e) => e.toJson()).toList()
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
            'parts': data.eyebrows.map((e) => e.toJson()).toList()
          },
          {
            'type': 'part',
            'title': '',
            'subpart': 'eyes',
            'parts': data.eyes.map((e) => e.toJson()).toList()
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
            'parts': data.noses.map((e) => e.toJson()).toList()
          },
          {
            'type': 'part',
            'title': '',
            'subpart': 'mouth',
            'parts': data.mouths.map((e) => e.toJson()).toList()
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
            'parts': data.clothes.map((e) => e.toJson()).toList()
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
            'parts': data.hats.map((e) => e.toJson()).toList()
          },
          {
            'type': 'part',
            'title': 'ACCESSORIES',
            'subpart': 'accessories',
            'parts': data.accessories.map((e) => e.toJson()).toList()
          },
        ]
      },
    ];

    var b = array.map((item) => AvatarPart.fromJson(item)).toList();
    return b;
  }

  var a = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.45, 1],
    colors: [hexToColor('#2A2A2A'), hexToColor('#2A2A2A')],
  );
  AvatarBloc _avatarBloc;
  PersonBloc _personBloc;
  // model.Person person;
  List<AvatarPart> partsData;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvatarBloc, AvatarState>(
        listener: (BuildContext context, AvatarState state) {
      if (state is AvatarLoaded) {
        model.Person initP;
        if (widget.initialAvatar == null) {
          initP = model.Person.fromJson(generateInitalPerson(state.avatars));
        }
        print("[INITIAL AVATAR] ${widget.initialAvatar}");
        List<AvatarPart> parts = generatePartsList(state.avatars);
        print('[PARTS] $parts');
        setState(() {
          person = widget.initialAvatar ?? initP;
          partsData = parts;
        });
      }
      // _personBloc.add(InitialPerson(
      //     background: initP.background.element,
      //     accessories: initP.accessories.element,
      //     backgroundColor: initP.background.color,
      //     clothes: initP.clothes.element,
      //     clothesColor: initP.clothes.color,
      //     eyebrows: initP.eyebrows.element,
      //     eyes: initP.eyes.element,
      //     eyesColor: initP.eyes.color,
      //     face_hairs: initP.faceHairs.element,
      //     face_hairsColor: initP.faceHairs.color,
      //     hair: initP.hair.element,
      //     hairColor: initP.hair.color,
      //     hats: initP.hats.element,
      //     head: initP.head.element,
      //     headColor: initP.head.color,
      //     mouth: initP.mouth.element,
      //     noses: initP.noses.element));
      // _avatarBloc
      //     .add(GeneratePartsList((generatePartsList(state.avatars))));
    }, builder: (BuildContext context, AvatarState state) {
      if (state is AvatarLoading || state is ListLoading) {
        return new Container(
          width: 20,
          height: 40,
          alignment: Alignment.center,
          child: new CircularProgressIndicator(
            valueColor:
                new AlwaysStoppedAnimation<Color>(hexToColor('#f44336')),
          ),
        );
      }
      return person != null
          ? Container(
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
                      _buildPerson(),
                      Padding(
                        padding: EdgeInsets.only(top: 25, bottom: 15),
                        child: PartsSwitch(
                            changePart: changePartOfAvatar,
                            parts: partsData,
                            activePartColor: widget.activePartColor,
                            partColor: widget.partColor,
                            partBorder: widget.partBorderColor,
                            activePart: partOfAvatar,
                            color: widget.elementsColor),
                      ),
                      CreateAvatarWrapper(
                          data: partsData,
                          person: person,
                          changeActiveElement: changeActiveElement,
                          hairs: hairs,
                          hatHairs: hatHairs,
                          changeColor: changeColor,
                          partOfAvatar: partOfAvatar)
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       top: 200 > 667 ? 32 : 25,
                      //       bottom: 200 > 667 ? 20 : 15),
                      //   child: PartsSwitch(
                      //       changePart: changePartOfAvatar,
                      //       parts: state.props.,
                      //       activePartColor: widget.activePartColor,
                      //       partColor: widget.partColor,
                      //       partBorder: widget.partBorderColor,
                      //       activePart: partOfAvatar,
                      //       color: widget.elementsColor),
                      // ),
                    ]))
              ]))
          : SizedBox();
    });
  }

  Widget _buildPerson() {
    return Row(
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
                            image: widget.avatarBg, fit: BoxFit.contain)
                        : null,
                    gradient: widget.avatarBg == null
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.45, 1],
                            colors: widget.elementsColor != null
                                ? [widget.elementsColor, widget.elementsColor]
                                : gradient,
                          )
                        : null,
                    boxShadow:
                        widget.elementsColor != null || widget.avatarBg != null
                            ? null
                            : shadow),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Transform.scale(
                    scale: 2,
                    child: RepaintBoundary(
                        key: Avatar._globalKey,
                        child: PersonMaket(
                          isFree: true,
                          head: person.head.element,
                          hats: person.hats.element,
                          headColor: person.head.color,
                          eyebrows: person.eyebrows.element,
                          hair: person.hair.element,
                          accessories: person.accessories.element,
                          faceHairs: person.faceHairs.element,
                          hairColor: person.faceHairs.color,
                          noses: person.noses.element,
                          eyes: person.eyes.element,
                          mouth: person.mouth.element,
                          background: person.background.element,
                          clothes: person.clothes.element,
                          bgColor: person.background.color,
                          clothesColor: person.clothes.color,
                          eyesColor: person.eyes.color,
                          mouthColor: Colors.white,
                        )),
                  ),
                )),
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
                  color: widget.textColor != null
                      ? widget.textColor
                      : hexToColor('#8D9CB3')),
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
    );
  }
  //  model.Person initP =
  //         model.Person.fromJson(generateInitalPerson(state.avatars));

  // },
  // );

  // if (parts != null) {
  //   active = parts.firstWhere((item) => item['part'] == partOfAvatar);
  // }

  // return parts != null
  // ? Container(
  //     decoration: BoxDecoration(
  //         color: widget.bgColor != null
  //             ? widget.bgColor
  //             : hexToColor('#E3EDF7'),
  //         image: widget.bgImage != null
  //             ? DecorationImage(fit: BoxFit.cover, image: widget.bgImage)
  //             : null),
  //     child: Column(children: <Widget>[
  //       new Container(
  //           padding: EdgeInsets.only(left: 14, right: 14),
  //           child: new Column(children: <Widget>[
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisSize: MainAxisSize.max,
  //               children: <Widget>[
  //                 Expanded(
  //                   child: Container(
  //                     alignment: Alignment.center,
  //                     child: Container(
  //                       alignment: Alignment.center,
  //                       margin: EdgeInsets.only(left: 80),
  //                       width: 142,
  //                       height: 142,
  //                       decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(38),
  //                           image: widget.avatarBg != null
  //                               ? DecorationImage(
  //                                   image: widget.avatarBg,
  //                                   fit: BoxFit.contain)
  //                               : null,
  //                           gradient: widget.avatarBg == null
  //                               ? LinearGradient(
  //                                   begin: Alignment.topLeft,
  //                                   end: Alignment.bottomRight,
  //                                   stops: [0.45, 1],
  //                                   colors: widget.elementsColor != null
  //                                       ? [
  //                                           widget.elementsColor,
  //                                           widget.elementsColor
  //                                         ]
  //                                       : gradient,
  //                                 )
  //                               : null,
  //                           boxShadow: widget.elementsColor != null ||
  //                                   widget.avatarBg != null
  //                               ? null
  //                               : shadow),
  //                       child: Padding(
  //                         padding: EdgeInsets.only(bottom: 20),
  //                         child: Transform.scale(
  //                           scale: 2,
  //                           child: RepaintBoundary(
  //                             key: Avatar._globalKey,
  //                             child: Person(
  //                               isFree: true,
  //                               head: person['head']['element'],
  //                               hats: person['hats']['element'],
  //                               headColor: person['head']['color'],
  //                               eyebrows: person['eyebrows']['element'],
  //                               hair: person['hair']['element'],
  //                               accessories: person['accessories']
  //                                   ['element'],
  //                               faceHair: person['face_hairs']['element'],
  //                               hairColor: person['face_hairs']['color'],
  //                               noses: person['noses']['element'],
  //                               eyes: person['eyes']['element'],
  //                               mouth: person['mouth']['element'],
  //                               background: person['background']
  //                                   ['element'],
  //                               clothes: person['clothes']['element'],
  //                               bgColor: person['background']['color'],
  //                               clothesColor: person['clothes']['color'],
  //                               eyesColor: person['eyes']['color'],
  //                               mouthColor: Colors.white,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   width: 88,
  //                   child: FlatButton(
  //                     child: Text(
  //                       'Restore\npurchase',
  //                       textAlign: TextAlign.center,
  //                       style: TextStyle(
  //                           fontSize: 12,
  //                           color: widget.textColor != null
  //                               ? widget.textColor
  //                               : hexToColor('#8D9CB3')),
  //                     ),
  //                     onPressed: () {
  //                       getPurchases(() {
  //                         if (widget.restoreCb != null) {
  //                           widget.restoreCb();
  //                         }
  //                       });
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Padding(
  //               padding: EdgeInsets.only(
  //                   top: height > 667 ? 32 : 25,
  //                   bottom: height > 667 ? 20 : 15),
  //               child: PartsSwitch(
  //                   changePart: changePartOfAvatar,
  //                   parts: parts,
  //                   activePartColor: widget.activePartColor,
  //                   partColor: widget.partColor,
  //                   partBorder: widget.partBorderColor,
  //                   activePart: partOfAvatar,
  //                   color: widget.elementsColor),
  //             ),
  //             Column(
  //                   children: active['items'].map<Widget>((item) {
  //                     bool show = item['subpart'] != 'background' ||
  //                         person['background']['element']['free'] &&
  //                             item['subpart'] == 'background' ||
  //                         item['title'] == 'BACKGROUND TYPE';
  //                     return Column(
  //                       children: <Widget>[
  //                         item['title'] != ''
  //                             ? show
  //                                 ? renderTitle(item['title'])
  //                                 : Container()
  //                             : Container(),
  //                         item['type'] == 'part'
  //                             ? ListOfElements(
  //                                 list: item,
  //                                 partOfAvatar: partOfAvatar,
  //                                 head: person['head']['element'],
  //                                 hats: person['hats']['element'],
  //                                 headColor: person['head']['color'],
  //                                 hair: person['hair']['element'],
  //                                 eyebrows: person['eyebrows']['element'],
  //                                 accessories: person['accessories']
  //                                     ['element'],
  //                                 bgColor: person['background']['color'],
  //                                 faceHair: person['face_hairs']['element'],
  //                                 hairColor: person['face_hairs']['color'],
  //                                 eyes: person['eyes']['element'],
  //                                 mouth: person['mouth']['element'],
  //                                 noses: person['noses']['element'],
  //                                 background: person['background']['element'],
  //                                 clothes: person['clothes']['element'],
  //                                 clothesColor: person['clothes']['color'],
  //                                 eyesColor: person['eyes']['color'],
  //                                 mouthColor: Colors.white,
  //                                 hairs: hairs,
  //                                 hatHairs: hatHairs,
  //                                 changeActiveElement: (element) {
  //                                   changeActiveElement(
  //                                     element,
  //                                     item['subpart'],
  //                                   );
  //                                 },
  //                                 fullVersion: fullVersion,
  //                                 person: person,
  //                                 color: widget.elementsColor)
  //                             : Container(),
  //                         item['type'] == 'pallet'
  //                             ? show
  //                                 ? Padding(
  //                                     padding:
  //                                         EdgeInsets.only(top: 5, bottom: 5),
  //                                     child: ColorChanger(
  //                                         bg: widget.elementsColor,
  //                                         color: person[item['subpart']]
  //                                             ['color'],
  //                                         onChanged: (color) {
  //                                           changeColor(
  //                                               color, item['subpart']);
  //                                         },
  //                                         displaySlider:
  //                                             item['slider'] == null,
  //                                         palette: item['colors']),
  //                                   )
  //                                 : Container()
  //                             : Container()
  //                       ],
  //                     );
  //                   }).toList(),
  //                 )
  //               ]))
  //         ]))
  // : new Container(
  //     width: 20,
  //     height: 40,
  //     alignment: Alignment.center,
  //     child: new CircularProgressIndicator(
  //       valueColor:
  //           new AlwaysStoppedAnimation<Color>(hexToColor('#f44336')),
  //     ),
  //   );

}
