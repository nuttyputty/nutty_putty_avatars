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

  @override
  PersonState fromJson(Map<String, dynamic> json) {
    try {
      final Person avatars = Person.fromJson(json);
      return PersonLoaded(avatars);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(PersonState state) {
    if (state is PersonLoaded) {
      return state.person.toJson();
    }

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
      yield PersonLoaded(event.initialPerson);
    } catch (err) {
      print(err);
      yield PersonError(err.toString());
    }
  }
}
