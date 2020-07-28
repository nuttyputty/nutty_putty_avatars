import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutty_putty_avatars/blocks/avatars/avatar_bloc.dart';
import 'package:nutty_putty_avatars/blocks/person/person.dart';
import 'package:nutty_putty_avatars/nutty_putty_avatars.dart';

class App extends StatelessWidget {
  App(
      {Key key,
      this.elementsColor,
      this.bgColor,
      this.restoreCb,
      this.partBorderColor,
      this.bgImage,
      this.avatarBg,
      this.iosList,
      this.androidList,
      this.textColor,
      this.isStaging,
      this.activePartColor,
      this.partColor,
      this.initialAvatar})
      : super(key: key);
  final bgImage;
  final bgColor;
  final elementsColor;
  final avatarBg;
  final Color activePartColor;
  final Color partColor;
  final textColor;
  final iosList;
  final isStaging;
  final restoreCb;
  final androidList;
  static GlobalKey _globalKey = new GlobalKey<AvatarStatea>();
  final initialAvatar;
  final partBorderColor;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AvatarBloc>(
            create: (BuildContext context) => AvatarBloc(),
          ),
          BlocProvider<PersonBloc>(
            create: (BuildContext context) => PersonBloc(),
          ),
        ],
        child: Avatar(
            elementsColor: elementsColor,
            bgColor: bgColor,
            restoreCb: restoreCb,
            partBorderColor: partBorderColor,
            bgImage: bgImage,
            avatarBg: avatarBg,
            iosList: iosList,
            androidList: androidList,
            textColor: textColor,
            isStaging: isStaging,
            activePartColor: activePartColor,
            partColor: partColor,
            initialAvatar: initialAvatar));
  }
}
