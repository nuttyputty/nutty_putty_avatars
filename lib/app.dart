import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutty_putty_avatars/blocks/avatars/avatar_bloc.dart';
import 'package:nutty_putty_avatars/blocks/person/person.dart';
import 'package:nutty_putty_avatars/nutty_putty_avatars.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AvatarBloc>(
        create: (BuildContext context) => AvatarBloc(),
      ),
      BlocProvider<PersonBloc>(
        create: (BuildContext context) => PersonBloc(),
      ),
    ], child: Avatar());
  }
}
