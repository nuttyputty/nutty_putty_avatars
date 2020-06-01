import 'package:flutter/material.dart';
import 'package:nutty_putty_avatars/app.dart';
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
  var a = Avatar();

  var c;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new ListView(
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          App(),
          // Avatar(
          //   bgColor: Colors.transparent,
          //   androidList: [],
          //   iosList: ['com.nuttyputty.partymafia.fullAvatars'],
          //   isStaging: true,
          // ),
        ],
      ),
    );
  }
}
