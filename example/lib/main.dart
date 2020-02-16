import 'package:flutter/material.dart';
import 'package:nutty_putty_avatars/nutty_putty_avatars.dart';
import 'package:image/image.dart' as I;
import 'dart:io';

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

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   a.takeImage();
  // }

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
              // print(a);

              // print(a);
              // var b = Image.memory(base64Decode(a));
              // var c = File;
              print(await AvatarState.takeImage());

              // await file.writeAsBytes(a);
            },
            child: Text('save'),
          ),
          avatar != null
              ? Image.memory(
                  avatar,
                  scale: 2,
                )
              : Container()
        ],
      ),
    );
  }
}
