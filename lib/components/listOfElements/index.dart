import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nutty_putty_avatars/components/person/index.dart';

import '../../services/hexToColor.dart';

class ListOfElements extends StatefulWidget {
  ListOfElements(
      {@required this.list,
      @required this.partOfAvatar,
      @required this.changeActiveElement,
      @required this.head,
      @required this.hair,
      @required this.eyes,
      @required this.mouth,
      @required this.faceHair,
      @required this.clothes,
      @required this.accessories,
      @required this.noses,
      @required this.headColor,
      @required this.background,
      @required this.bgColor,
      @required this.hairColor,
      @required this.eyesColor,
      @required this.eyebrows,
      @required this.mouthColor,
      @required this.clothesColor,
      @required this.hats,
      this.person,
      this.fullVersion,
      this.color,
      this.hairs,
      this.hatHairs});
  final list;
  final int partOfAvatar;
  final Function changeActiveElement;
  final head;
  final hairs;
  final person;
  final hatHairs;
  final bgColor;
  final noses;
  final hair;
  final eyes;
  final mouth;
  final background;
  final eyebrows;
  final accessories;
  final faceHair;
  final clothes;
  final headColor;
  final hairColor;
  final eyesColor;
  final mouthColor;
  final clothesColor;
  final color;
  final hats;
  final fullVersion;
  _ListOfElementsState createState() => _ListOfElementsState();
}

class _ListOfElementsState extends State<ListOfElements> {
  ScrollController _scrollController;
  double _scrollPosition;
  double maxScroll;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
      maxScroll = _scrollController.position.maxScrollExtent;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    Future.delayed(Duration.zero, () {
      setState(() {
        maxScroll = _scrollController.position.maxScrollExtent;
        _scrollPosition = 0;
      });
    });
    super.initState();
  }

  @override
  void didUpdateWidget(oldWidget) {
    if (oldWidget.list['subpart'] != widget.list['subpart']) {
      _scrollController.jumpTo(0);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.deactivate();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return new Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        height: 78,
        constraints: BoxConstraints(minWidth: width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.45, 1],
            colors: widget.color != null
                ? [widget.color, widget.color]
                : [
                    hexToColor('#E3EDF7').withOpacity(1),
                    Color.fromRGBO(255, 255, 255, 0.7)
                  ],
          ),
        ),
        child: Stack(
          children: <Widget>[
            _scrollPosition != 0
                ? Positioned(
                    left: 3,
                    top: 3,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                    ),
                  )
                : SizedBox(),
            new ListView(
              shrinkWrap: true,
              controller: _scrollController,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: widget.list['parts'].map<Widget>((item) {
                var active = widget.person[widget.list['subpart']]['element']
                        ['id'] ==
                    item['id'];

                var hairPart = widget.hair;
                if (widget.list['subpart'] == 'hats') {
                  var index = widget.hatHairs
                      .indexWhere((i) => widget.hair['id'] == i['id']);

                  if (index == -1) {
                    index = widget.hairs
                        .indexWhere((i) => widget.hair['id'] == i['id']);
                  }
                  if (index != -1) {
                    hairPart = item['image'] != null
                        ? widget.hatHairs[index]
                        : widget.hairs[index];
                  }
                }
                return Padding(
                  padding: EdgeInsets.only(left: 7.5, right: 7.5),
                  child: new IconButton(
                      onPressed: () {
                        widget.changeActiveElement(item);
                      },
                      icon: Transform.scale(
                          scale: 1.8,
                          child:
                              //  Person(
                              //   isFree: widget.fullVersion ? true : item['free'],
                              //   active: active,
                              //   head: widget.list['subpart'] == 'head'
                              //       ? item
                              //       : widget.head,
                              //   headColor: widget.headColor,
                              //   eyebrows: widget.list['subpart'] == 'eyebrows'
                              //       ? item
                              //       : widget.eyebrows,
                              //   noses: widget.list['subpart'] == 'noses'
                              //       ? item
                              //       : widget.noses,
                              //   hair: widget.list['subpart'] == 'hair'
                              //       ? item
                              //       : hairPart,
                              //   bgColor: widget.bgColor,
                              //   hairColor: widget.hairColor,
                              //   hats: widget.list['subpart'] == 'hats'
                              //       ? item
                              //       : widget.hats,
                              //   eyes: widget.list['subpart'] == 'eyes'
                              //       ? item
                              //       : widget.eyes,
                              //   mouth: widget.list['subpart'] == 'mouth'
                              //       ? item
                              //       : widget.mouth,
                              //   clothes: widget.list['subpart'] == 'clothes'
                              //       ? item
                              //       : widget.clothes,
                              //   background: widget.list['subpart'] == 'background'
                              //       ? item
                              //       : widget.background,
                              //   faceHair: widget.list['subpart'] == 'face_hairs'
                              //       ? item
                              //       : widget.faceHair,
                              //   clothesColor: widget.clothesColor,
                              //   accessories: widget.list['subpart'] == 'accessories'
                              //       ? item
                              //       : widget.accessories,
                              //   eyesColor: widget.eyesColor,
                              //   mouthColor: Colors.white,
                              // )
                              Container())),
                );
              }).toList(),
            ),
            _scrollPosition != maxScroll
                ? Positioned(
                    right: 3,
                    top: 3,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  )
                : SizedBox(),
          ],
        ));
  }
}
