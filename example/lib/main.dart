import 'package:flutter/material.dart';
import 'package:nutty_putty_avatars/app.dart';
import 'package:nutty_putty_avatars/blocks/avatars/avatar.dart';
import 'package:nutty_putty_avatars/nutty_putty_avatars.dart';

import 'dart:ui';

import 'package:nutty_putty_avatars/services/hexToColor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Avatar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var avatar;

  var c;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new ListView(
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          App(
            bgColor: Colors.transparent,
            androidList: ['com.nuttyputty.partymafia.fullAvatars'],
            iosList: ['com.nuttyputty.partymafia.fullAvatars'],
            isStaging: true,
          ),
          // Avatar(
          //   bgColor: Colors.transparent,
          //   androidList: [],
          //   iosList: ['com.nuttyputty.partymafia.fullAvatars'],
          //   isStaging: true,
          // ),
          RaisedButton(onPressed: () async {
            var data = await AvatarStatea.takeImage();
            var data2 = await AvatarStatea.getParts();
            var v = data;
            setState(() {
              c = v;
            });
          }),
          c != null
              ? Image.memory(
                  c,
                  scale: 2,
                )
              : Container()
        ],
      ),
    );
  }
}
