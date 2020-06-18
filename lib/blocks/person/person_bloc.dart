import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nutty_putty_avatars/blocks/person/person_state.dart';
import 'package:nutty_putty_avatars/models/avatar.dart';
import 'package:nutty_putty_avatars/models/person.dart';
import 'package:nutty_putty_avatars/services/request.dart';

import 'person_event.dart';
import 'person_event.dart';

class PersonBloc extends Bloc<PersonEvents, PersonState> {
  @override
  PersonState get initialState {
    // super.initialState;
    return PersonInitial();
  }

  PersonState fromJson(Map<String, dynamic> json) {
    try {
      final Person avatars = Person.fromJson(json);
      return PersonLoaded(
          background: avatars.background.element,
          accessories: avatars.accessories.element,
          backgroundColor: avatars.background.color,
          clothes: avatars.clothes.element,
          clothesColor: avatars.clothes.color,
          eyebrows: avatars.eyebrows.element,
          eyes: avatars.eyes.element,
          eyesColor: avatars.eyes.color,
          face_hairs: avatars.faceHairs.element,
          face_hairsColor: avatars.faceHairs.color,
          hair: avatars.hair.element,
          hairColor: avatars.hair.color,
          hats: avatars.hats.element,
          head: avatars.head.element,
          headColor: avatars.head.color,
          mouth: avatars.mouth.element,
          noses: avatars.noses.element);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(PersonState state) {
    // if (state is PersonLoaded) {
    //   return state.person.toJson();
    // }

    return null;
  }

  @override
  Stream<PersonState> mapEventToState(
    PersonEvents event,
  ) async* {
    if (event is ChangePerson) {
      yield PersonLoading();
      yield* _mapStateFromGetAvatars(event);
    }
    if (event is InitialPerson) {
      yield PersonLoading();
      yield* _mapStateFromInitPerson(event);
    }

    if (event is CustomPerson) {
      // yield PersonLoading();
      yield* _mapStateFromCustomPerson(event);
    }
  }

  Stream<PersonState> _mapStateFromGetAvatars(ChangePerson event) async* {
    try {
      // final Person response = await _avatarService.getImages();
      // yield PersonLoaded(response);
    } catch (err) {
      print(err);
      yield PersonError(err.toString());
    }
  }

  Stream<PersonState> _mapStateFromInitPerson(InitialPerson event) async* {
    try {
      // final Person response = await _avatarService.getImages();

      print('TYTYTYTYT');
      yield PersonLoaded(
          background: event.background,
          accessories: event.accessories,
          backgroundColor: event.backgroundColor,
          clothes: event.clothes,
          clothesColor: event.clothesColor,
          eyebrows: event.eyebrows,
          eyes: event.eyes,
          eyesColor: event.eyesColor,
          face_hairs: event.face_hairs,
          face_hairsColor: event.face_hairsColor,
          hair: event.hair,
          hairColor: event.hairColor,
          hats: event.hats,
          head: event.head,
          headColor: event.headColor,
          mouth: event.mouth,
          noses: event.noses);
    } catch (err) {
      print(err);
      yield PersonError(err.toString());
    }
  }

  Stream<PersonState> _mapStateFromCustomPerson(CustomPerson event) async* {
    try {
      // final Person response = await _avatarService.getImages();
      yield (state as PersonLoaded).copyWith(
          background: event.background,
          accessories: event.accessories,
          backgroundColor: event.backgroundColor,
          clothes: event.clothes,
          clothesColor: event.clothesColor,
          eyebrows: event.eyebrows,
          eyes: event.eyes,
          eyesColor: event.eyesColor,
          face_hairs: event.face_hairs,
          face_hairsColor: event.face_hairsColor,
          hair: event.hair,
          hairColor: event.hairColor,
          hats: event.hats,
          head: event.head,
          headColor: event.headColor,
          mouth: event.mouth,
          noses: event.noses);
      print('TYTYTYTYT');
      // yield PersonLoaded(
      //     background: event.background,
      //     accessories: event.accessories,
      //     backgroundColor: event.backgroundColor,
      //     clothes: event.clothes,
      //     clothesColor: event.clothesColor,
      //     eyebrows: event.eyebrows,
      //     eyes: event.eyes,
      //     eyesColor: event.eyesColor,
      //     face_hairs: event.face_hairs,
      //     face_hairsColor: event.face_hairsColor,
      //     hair: event.hair,
      //     hairColor: event.hairColor,
      //     hats: event.hats,
      //     head: event.head,
      //     headColor: event.headColor,
      //     mouth: event.mouth,
      //     noses: event.noses);
    } catch (err) {
      print(err);
      yield PersonError(err.toString());
    }
  }
}
