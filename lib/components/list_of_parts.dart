import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutty_putty_avatars/blocks/blocs.dart';
import 'package:nutty_putty_avatars/components/person/index.dart';
import 'package:nutty_putty_avatars/models/part.dart';
import 'package:nutty_putty_avatars/models/person.dart' as models;
import 'package:nutty_putty_avatars/models/person.dart';
import 'package:nutty_putty_avatars/services/hexToColor.dart';
import 'package:nutty_putty_avatars/services/renderSvg.dart';
import 'package:nutty_putty_avatars/styles/index.dart';

// import '../../services/renderSvg.dart';
// import '../../services/shadow.dart';

class ListOfParts extends StatelessWidget {
  ListOfParts({this.list});
  List<models.Element> list;

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
                // return renderSvg(list[i]);
                return PersonMaket(
                  customPerson: list[i],
                );
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
}
