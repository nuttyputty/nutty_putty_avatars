import 'package:flutter/material.dart';
import 'package:nutty_putty_avatars/nutty_putty_avatars.dart';

import 'dart:ui';

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
      body: ListView(
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Avatar(
            bgColor: Colors.transparent,
          ),
          FlatButton(
            onPressed: () async {
              var a = await takeImage();

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
