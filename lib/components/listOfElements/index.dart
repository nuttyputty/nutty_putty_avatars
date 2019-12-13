import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../services/renderSvg.dart';
import '../../services/shadow.dart';

class ListOfElements extends StatelessWidget {
  ListOfElements({
    @required this.list,
    @required this.changeActiveElement,
    @required this.activeElementColor,
  });
  final List list;
  final Function changeActiveElement;
  final HSVColor activeElementColor;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return new Container(
      height: 80,
      constraints: BoxConstraints(minWidth: width),
      decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black,
          offset: Offset(0, 0),
          blurRadius: 10.0,
        )
      ]),
      child: new ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: list
            .map<Widget>((item) => Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: new IconButton(
                    onPressed: () {
                      changeActiveElement(item);
                    },
                    icon: Transform.scale(
                        scale: 3,
                        child: new Stack(
                          children: <Widget>[
                            renderSvg(
                                item['image'], activeElementColor.toColor()),
                            renderSvg(item['shadow'],
                                calculateShadowColor(activeElementColor)),
                          ],
                        )))))
            .toList(),
      ),
    );
  }
}
