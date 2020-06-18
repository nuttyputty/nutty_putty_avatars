import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
// import 'package:nutty_putty_avatars/components/person/index.dart';
import 'package:nutty_putty_avatars/models/person.dart';

@immutable
abstract class PersonEvents extends Equatable {
  const PersonEvents();

  @override
  List<Object> get props => <dynamic>[];
}

class ChangePerson extends PersonEvents {
  final Person data;
  ChangePerson(this.data);

  @override
  List<Object> get props => [data];
}

class InitialPerson extends PersonEvents {
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
  InitialPerson(
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

  @override
  List<Object> get props => [
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

class CustomPerson extends PersonEvents {
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
  CustomPerson(
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

  @override
  List<Object> get props => [
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
