import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PartsSwitch extends StatelessWidget {
  PartsSwitch({@required this.changePart, this.parts});
  final List parts;
  final Function changePart;

  switchButton(data) {
    return new RaisedButton(
      onPressed: () {
        changePart(data['partOfAvatar']);
      },
      color: Colors.blue,
      child: new Text(data['partOfAvatar'] == 0
          ? 'head'
          : data['partOfAvatar'] == 1 ? 'hair' : 'clothes'),
    );
  }

  @override
  Widget build(context) {
    return Container(
        height: 60,
        decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 0),
            blurRadius: 10.0,
          )
        ]),
        child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                parts.map<Widget>((item) => switchButton(item)).toList()));
  }
}
