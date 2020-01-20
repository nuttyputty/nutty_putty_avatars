import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nutty_putty_avatars/services/hexToColor.dart';
import 'package:nutty_putty_avatars/services/renderSvg.dart';

class PartsSwitch extends StatelessWidget {
  PartsSwitch({@required this.changePart, this.activePart, this.parts});
  final List parts;
  final Function changePart;
  final int activePart;

  switchButton(data) {
    var active = data['partOfAvatar'] == activePart;
    return new IconButton(
      padding: EdgeInsets.all(0),
      onPressed: () {
        changePart(data['partOfAvatar']);
      },
      color: Colors.blue,
      icon: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: active
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
        child: renderSvgWithColor(data['image'],
            active ? hexToColor('#C4CFDE') : data['color'], true),
      ),
    );
  }

  @override
  Widget build(context) {
    return Container(
        height: 44,
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
            color: hexToColor('#FFFFFF').withOpacity(0.45),
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 0.4),
                offset: Offset(-3, -3),
                blurRadius: 10,
              ),
              BoxShadow(
                color: Color.fromRGBO(152, 176, 199, 0.25),
                offset: Offset(3, 3),
                blurRadius: 5,
              ),
            ]),
        child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                parts.map<Widget>((item) => switchButton(item)).toList()));
  }
}
