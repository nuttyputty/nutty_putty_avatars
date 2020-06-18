// import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:nutty_putty_avatars/models/person.dart';

@immutable
abstract class PersonState extends Equatable {
  const PersonState();

  @override
  List<Object> get props => <Object>[];
}

class PersonInitial extends PersonState {}

class PersonLoading extends PersonState {}

class PersonLoaded extends PersonState {
  String backgroundColor;
  Element background;
  String headColor;
  Element head;

  String hairColor;
  Element hair;

  Element hats;

  String eyesColor;
  Element eyes;

  Element mouth;
  Element noses;
  String face_hairsColor;
  Element face_hairs;
  String clothesColor;
  Element clothes;
  Element accessories;
  Element eyebrows;
  PersonLoaded(
      {this.backgroundColor,
      this.background,
      this.headColor,
      this.head,
      this.hairColor,
      this.hair,
      this.hats,
      this.eyesColor,
      this.eyes,
      this.mouth,
      this.noses,
      this.face_hairsColor,
      this.face_hairs,
      this.clothesColor,
      this.clothes,
      this.accessories,
      this.eyebrows});

  PersonLoaded copyWith(
      {String backgroundColor,
      Element background,
      String headColor,
      Element head,
      String hairColor,
      Element hair,
      Element hats,
      String eyesColor,
      Element eyes,
      Element mouth,
      Element noses,
      String face_hairsColor,
      Element face_hairs,
      String clothesColor,
      Element clothes,
      Element accessories,
      Element eyebrows}) {
    return PersonLoaded(
        background: background ?? this.background,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        headColor: headColor ?? this.headColor,
        head: head ?? this.head,
        hairColor: hairColor ?? this.hairColor,
        hair: hair ?? this.hair,
        hats: hats ?? this.hats,
        eyesColor: eyesColor ?? this.eyesColor,
        eyes: eyes ?? this.eyes,
        mouth: mouth ?? this.mouth,
        noses: noses ?? this.noses,
        face_hairsColor: face_hairsColor ?? this.face_hairsColor,
        face_hairs: face_hairs ?? this.face_hairs,
        clothesColor: clothesColor ?? this.clothesColor,
        clothes: clothes ?? this.clothes,
        accessories: accessories ?? this.accessories,
        eyebrows: eyebrows ?? this.eyebrows);
  }

  @override
  List<Object> get props => <Object>[
        backgroundColor,
        background,
        headColor,
        head,
        hairColor,
        hair,
        hats,
        eyesColor,
        eyes,
        mouth,
        noses,
        face_hairsColor,
        face_hairs,
        clothesColor,
        clothes,
        accessories,
        eyebrows
      ];
}

class PersonError extends PersonState {
  final String message;

  PersonError(this.message);

  @override
  List<Object> get props => <Object>[message];
}
//  'background': {
//         'color': bgPalette[5],
//         'element': avatars.backgrounds[0].toJson()
//       },
//       'head': {'color': headPalette[1], 'element': avatars.heads[0].toJson()},
//       'hair': {'color': hairPalette[0], 'element': avatars.hairs[0].toJson()},
//       'hats': {'element': avatars.hats[0].toJson()},
//       'eyes': {'element': avatars.eyes[0].toJson(), 'color': eyesPalette[0]},
//       'noses': {'element': avatars.noses[0].toJson()},
//       'mouth': {'element': avatars.mouths[0].toJson()},
//       'face_hairs': {
//         'color': hairPalette[0],
//         'element': avatars.faceHairs[0].toJson()
//       },
//       'clothes': {
//         'color': clothPalette[0],
//         'element': avatars.clothes[0].toJson()
//       },
//       'accessories': {'element': avatars.accessories[0].toJson()},
//       'eyebrows': {'element': avatars.eyebrows[0].toJson()}
