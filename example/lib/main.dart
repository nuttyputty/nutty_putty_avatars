import 'package:flutter/material.dart';
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
          Container(
            height: 200,
            color: Colors.green,
            width: 120,
          ),
          Avatar(
            bgColor: Colors.transparent,
            initialAvatar: {
              'background': {
                'color': Color(0xff7784fc),
                'element': {
                  'id': '5e6a54e1844303000869ad92',
                  'image':
                      'https://s3.us-west-1.amazonaws.com/images.avatars/store/background/5e6a54e1844303000869ad92/image/b2c8039132381e27e5ac41bacf47978c.svg',
                  'free': false
                }
              },
              'head': {
                'color': Color(0xfff3d5a7),
                'element': {
                  'id': '5e6a5843844303000869adc9',
                  'image':
                      'https://s3.us-west-1.amazonaws.com/images.avatars/store/head/5e6a5843844303000869adc9/image/b4d964dee872ad053d0c9e0c7190e777.svg',
                  'free': true,
                  'shadow_image':
                      'https://s3.us-west-1.amazonaws.com/images.avatars/store/head/5e6a5843844303000869adc9/shadow_image/24be957103e36fa213fb2abbb1c60da6.svg'
                }
              },
              'hair': {
                'color': Color(0xff32302e),
                'element': {
                  'id': '5e6b6489e787f20008504f10',
                  'image': null,
                  'free': true,
                  'shadow_image': null,
                  'long_hair_image': null
                }
              },
              'hats': {
                'element': {
                  'id': '5e6b7c06e787f20008504f13',
                  'image': null,
                  'free': true,
                  'back_image': null
                }
              }
            },
            isStaging: true,
            androidList: ['com.nuttyputty.partymafia.avatars'],
            iosList: ['com.nuttyputty.partymafia.avatars'],
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
