import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nutty_putty_avatars/nutty_putty_avatars.dart';

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
          Avatar(
            bgColor: Colors.transparent,
            isStaging: true,
          ),
          FlatButton(
            onPressed: () async {
              var a = await AvatarState.takeImage();

              var v = a['image'];
              setState(() {
                c = v;
              });
            },
            child: Text('save'),
          ),
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
