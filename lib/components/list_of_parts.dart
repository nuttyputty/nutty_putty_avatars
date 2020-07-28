import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutty_putty_avatars/blocks/blocs.dart';
import 'package:nutty_putty_avatars/components/person/index.dart';
import 'package:nutty_putty_avatars/models/avatar.dart';
import 'package:nutty_putty_avatars/models/part.dart';
import 'package:nutty_putty_avatars/models/person.dart' as models;
import 'package:nutty_putty_avatars/models/person.dart';
import 'package:nutty_putty_avatars/services/hexToColor.dart';
import 'package:nutty_putty_avatars/services/renderSvg.dart';
import 'package:nutty_putty_avatars/styles/index.dart';

// import '../../services/renderSvg.dart';
// import '../../services/shadow.dart';

class ListOfParts extends StatelessWidget {
  ListOfParts(
      {@required this.list,
      @required this.activePerson,
      @required this.subpart,
      @required this.hairs,
      @required this.hatHairs,
      @required this.changeActiveElement,
      @required this.partOfAvatar});
  final List<models.Element> list;
  final models.Person activePerson;
  final List<Hairs> hairs;
  final List<HatHairs> hatHairs;
  final String subpart;
  final int partOfAvatar;
  final Function changeActiveElement;
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        height: 78,
        // constraints: BoxConstraints(minWidth: width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.45, 1],
            colors:
                // widget.color != null
                //     ? [widget.color, widget.color]
                //     :
                [
              hexToColor('#E3EDF7').withOpacity(1),
              Color.fromRGBO(255, 255, 255, 0.7)
            ],
          ),
        ),
        child: Stack(children: <Widget>[
          // _scrollPosition != 0
          //     ? Positioned(
          //         left: 3,
          //         top: 3,
          //         child: Icon(
          //           Icons.arrow_back_ios,
          //           size: 16,
          //         ),
          //       )
          //     : SizedBox(),
          ListView.builder(
              shrinkWrap: true,
              // controller: _scrollController,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int i) {
                var active = _data(subpart, list[i].id);

                models.Element hairPart = activePerson.hair.element;
                if (subpart == 'hats') {
                  int index = hatHairs
                      .indexWhere((i) => activePerson.hair.element.id == i.id);

                  if (index == -1) {
                    index = hairs.indexWhere(
                        (i) => activePerson.hair.element.id == i.id);
                  }

                  if (index != -1) {
                    hairPart = list[i].image != null
                        ? models.Element.fromJson(hatHairs[index].toJson())
                        : models.Element.fromJson(hairs[index].toJson());
                  }
                }
                // return renderSvg(list[i]);

                return new IconButton(
                    onPressed: () {
                      changeActiveElement(list[i], subpart);
                    },
                    icon: Transform.scale(
                        scale: 1.8,
                        child: PersonMaket(
                          isFree: list[i].free,
                          active: active,
                          head: subpart == 'head'
                              ? list[i]
                              : activePerson.head.element,
                          hats: subpart == 'hats'
                              ? list[i]
                              : activePerson.hats.element,
                          headColor: activePerson.head.color,
                          eyebrows: subpart == 'eyebrows'
                              ? list[i]
                              : activePerson.eyebrows.element,
                          hair: subpart == 'hair' ? list[i] : hairPart,
                          accessories: subpart == 'accessories'
                              ? list[i]
                              : activePerson.accessories.element,
                          faceHairs: subpart == 'face_hairs'
                              ? list[i]
                              : activePerson.faceHairs.element,
                          hairColor: activePerson.faceHairs.color,
                          noses: subpart == 'noses'
                              ? list[i]
                              : activePerson.noses.element,
                          eyes: subpart == 'eyes'
                              ? list[i]
                              : activePerson.eyes.element,
                          mouth: subpart == 'mouth'
                              ? list[i]
                              : activePerson.mouth.element,
                          background: subpart == 'background'
                              ? list[i]
                              : activePerson.background.element,
                          clothes: subpart == 'clothes'
                              ? list[i]
                              : activePerson.clothes.element,
                          bgColor: activePerson.background.color,
                          clothesColor: activePerson.clothes.color,
                          eyesColor: activePerson.eyes.color,
                          mouthColor: Colors.white,
                        )));
              }),
          // new ListView(
          // shrinkWrap: true,
          // controller: _scrollController,
          // physics: ClampingScrollPhysics(),
          // scrollDirection: Axis.horizontal,
          //     children: list.map<Widget>((item) {
          //       return Container();
          //     }))
        ]));
  }

  bool _data(String element, id) {
    switch (element) {
      case 'background':
        return activePerson.background.element.id == id;
        break;
      case 'accessories':
        return activePerson.accessories.element.id == id;
        break;
      case 'face_hairs':
        return activePerson.faceHairs.element.id == id;
        break;
      case 'clothes':
        return activePerson.clothes.element.id == id;
        break;
      case 'eyebrows':
        return activePerson.eyebrows.element.id == id;
        break;
      case 'eyes':
        return activePerson.eyes.element.id == id;
        break;
      case 'hair':
        return activePerson.hair.element.id == id;
        break;
      case 'hats':
        return activePerson.hats.element.id == id;
        break;
      case 'head':
        return activePerson.head.element.id == id;
        break;
      case 'mouth':
        return activePerson.mouth.element.id == id;
        break;
    }
  }
}
