import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutty_putty_avatars/blocks/blocs.dart';
import 'package:nutty_putty_avatars/components/person/index.dart';
import 'package:nutty_putty_avatars/models/avatar.dart';
import 'package:nutty_putty_avatars/models/part.dart';
import 'package:nutty_putty_avatars/models/person.dart' as models;
import 'package:nutty_putty_avatars/models/person.dart';
import 'package:nutty_putty_avatars/services/hexToColor.dart';
import 'package:nutty_putty_avatars/services/renderSvg.dart';
import 'package:nutty_putty_avatars/styles/index.dart';

// import '../../services/renderSvg.dart';
// import '../../services/shadow.dart';

class ListOfParts extends StatefulWidget {
  ListOfParts(
      {Key key,
      @required this.list,
      @required this.activePerson,
      @required this.subpart,
      @required this.hairs,
      @required this.hatHairs,
      @required this.changeActiveElement,
      @required this.fullVersion,
      @required this.partOfAvatar,
      this.color})
      : super(key: key);
  final Color color;
  final List<models.Element> list;
  final models.Person activePerson;
  final List<Hairs> hairs;
  final List<HatHairs> hatHairs;
  final String subpart;
  final int partOfAvatar;
  final Function changeActiveElement;
  final bool fullVersion;
  _ListOfPartsState createState() => _ListOfPartsState();
}

class _ListOfPartsState extends State<ListOfParts> {
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
    if (oldWidget.subpart != widget.subpart) {
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

  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
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
        child: Stack(children: <Widget>[
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
          ListView.builder(
              shrinkWrap: true,
              controller: _scrollController,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget.list.length,
              itemBuilder: (BuildContext context, int i) {
                var active = _data(widget.subpart, widget.list[i].id);

                models.Element hairPart = widget.activePerson.hair.element;
                if (widget.subpart == 'hats') {
                  int index = widget.hatHairs.indexWhere(
                      (i) => widget.activePerson.hair.element.id == i.id);

                  if (index == -1) {
                    index = widget.hairs.indexWhere(
                        (i) => widget.activePerson.hair.element.id == i.id);
                  }

                  if (index != -1) {
                    hairPart = widget.list[i].image != null
                        ? models.Element.fromJson(
                            widget.hatHairs[index].toJson())
                        : models.Element.fromJson(widget.hairs[index].toJson());
                  }
                }
                // return renderSvg(list[i]);

                return new IconButton(
                    onPressed: () {
                      widget.changeActiveElement(
                          widget.list[i], widget.subpart);
                    },
                    icon: Transform.scale(
                        scale: 1.8,
                        child: PersonMaket(
                          isFree:
                              widget.fullVersion ? true : widget.list[i].free,
                          active: active,
                          head: widget.subpart == 'head'
                              ? widget.list[i]
                              : widget.activePerson.head.element,
                          hats: widget.subpart == 'hats'
                              ? widget.list[i]
                              : widget.activePerson.hats.element,
                          headColor: widget.activePerson.head.color,
                          eyebrows: widget.subpart == 'eyebrows'
                              ? widget.list[i]
                              : widget.activePerson.eyebrows.element,
                          hair: widget.subpart == 'hair'
                              ? widget.list[i]
                              : hairPart,
                          accessories: widget.subpart == 'accessories'
                              ? widget.list[i]
                              : widget.activePerson.accessories.element,
                          faceHairs: widget.subpart == 'face_hairs'
                              ? widget.list[i]
                              : widget.activePerson.faceHairs.element,
                          hairColor: widget.activePerson.faceHairs.color,
                          noses: widget.subpart == 'noses'
                              ? widget.list[i]
                              : widget.activePerson.noses.element,
                          eyes: widget.subpart == 'eyes'
                              ? widget.list[i]
                              : widget.activePerson.eyes.element,
                          mouth: widget.subpart == 'mouth'
                              ? widget.list[i]
                              : widget.activePerson.mouth.element,
                          background: widget.subpart == 'background'
                              ? widget.list[i]
                              : widget.activePerson.background.element,
                          clothes: widget.subpart == 'clothes'
                              ? widget.list[i]
                              : widget.activePerson.clothes.element,
                          bgColor: widget.activePerson.background.color,
                          clothesColor: widget.activePerson.clothes.color,
                          eyesColor: widget.activePerson.eyes.color,
                          mouthColor: Colors.white,
                        )));
              }),
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
          // new ListView(
          // shrinkWrap: true,
          // controller: _scrollController,
          // physics: ClampingScrollPhysics(),
          // scrollDirection: Axis.horizontal,
          //     children: list.map<Widget>((item) {
          //       return Container();
          //     }))
        ]));
  }

  bool _data(String element, id) {
    switch (element) {
      case 'background':
        return widget.activePerson.background.element.id == id;
        break;
      case 'accessories':
        return widget.activePerson.accessories.element.id == id;
        break;
      case 'face_hairs':
        return widget.activePerson.faceHairs.element.id == id;
        break;
      case 'clothes':
        return widget.activePerson.clothes.element.id == id;
        break;
      case 'eyebrows':
        return widget.activePerson.eyebrows.element.id == id;
        break;
      case 'eyes':
        return widget.activePerson.eyes.element.id == id;
        break;
      case 'hair':
        return widget.activePerson.hair.element.id == id;
        break;
      case 'hats':
        return widget.activePerson.hats.element.id == id;
        break;
      case 'head':
        return widget.activePerson.head.element.id == id;
        break;
      case 'mouth':
        return widget.activePerson.mouth.element.id == id;
        break;
    }
  }
}
