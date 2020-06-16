import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutty_putty_avatars/blocks/blocs.dart';
import 'package:nutty_putty_avatars/models/part.dart';
import 'package:nutty_putty_avatars/services/hexToColor.dart';

import 'list_of_parts.dart';

class CreateAvatarWrapper extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocConsumer<AvatarBloc, AvatarState>(
      listener: (BuildContext context, AvatarState state) {},
      builder: (BuildContext context, AvatarState state) {
        if (state is ListGenerated) {
          return renderMainPart(state.parts);
        }

        return Container(
          height: 40,
          width: 40,
          color: Colors.yellow,
        );
      },
    );
  }

  renderMainPart(List<AvatarPart> list) {
    List<Items> parts = list[2].items;
    return ListView.builder(
        shrinkWrap: true,
        itemCount: parts.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              parts[index].title != ''
                  ? renderTitle(parts[index].title)
                  : SizedBox(),
              parts[index].type == 'part'
                  ? ListOfParts(
                      list: parts[1].parts,
                    )
                  : SizedBox()
            ],
          );
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
}

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
// ? ListOfElements(
//     list: item,
//     partOfAvatar: partOfAvatar,
//     head: person['head']['element'],
//     hats: person['hats']['element'],
//     headColor: person['head']['color'],
//     hair: person['hair']['element'],
//     eyebrows: person['eyebrows']['element'],
//     accessories: person['accessories']
//         ['element'],
//     bgColor: person['background']['color'],
//     faceHair: person['face_hairs']['element'],
//     hairColor: person['face_hairs']['color'],
//     eyes: person['eyes']['element'],
//     mouth: person['mouth']['element'],
//     noses: person['noses']['element'],
//     background: person['background']['element'],
//     clothes: person['clothes']['element'],
//     clothesColor: person['clothes']['color'],
//     eyesColor: person['eyes']['color'],
//     mouthColor: Colors.white,
//     hairs: hairs,
//     hatHairs: hatHairs,
//     changeActiveElement: (element) {
//       changeActiveElement(
//         element,
//         item['subpart'],
//       );
//     },
//     fullVersion: fullVersion,
//     person: person,
//     color: widget.elementsColor)
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
