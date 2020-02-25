import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nutty_putty_avatars/services/hexToColor.dart';
import 'package:nutty_putty_avatars/services/renderSvg.dart';

class PartsSwitch extends StatelessWidget {
  PartsSwitch(
      {@required this.changePart,
      this.partBorder,
      this.activePart,
      this.parts,
      this.color});
  final List parts;
  final partBorder;
  final Function changePart;
  final int activePart;
  final color;

  switchButton(data, index) {
    bool active = index == activePart;
    return new IconButton(
      padding: EdgeInsets.all(0),
      onPressed: () {
        changePart(index);
      },
      color: Colors.blue,
      icon: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: partBorder != null && active
                ? Border.all(color: partBorder, width: 1)
                : null,
            gradient: active && partBorder == null
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.5, 0.9],
                    colors: [
                      hexToColor('#E3EDF7'),
                      Color.fromRGBO(255, 255, 255, 0.7)
                    ],
                  )
                : null),
        padding: EdgeInsets.all(6),
        child: renderSvgWithColor(
            data, active ? hexToColor('#C4CFDE') : hexToColor('#8D9CB3'), true),
      ),
    );
  }

  @override
  Widget build(context) {
    return Container(
        height: 44,
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          color:
              color != null ? color : hexToColor('#FFFFFF').withOpacity(0.95),
          borderRadius: BorderRadius.circular(10),
          // boxShadow: <BoxShadow>[
          //   BoxShadow(
          //     color: Color.fromRGBO(255, 255, 255, 0.4),
          //     offset: Offset(-3, -3),
          //     blurRadius: 10,
          //   ),
          //   BoxShadow(
          //     color: Color.fromRGBO(152, 176, 199, 0.25),
          //     offset: Offset(3, 3),
          //     blurRadius: 5,
          //   ),
          // ]
        ),
        child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: parts.map<Widget>((item) {
              int index = parts.indexOf(item);
              return switchButton(item, index);
            }).toList()));
  }
}
