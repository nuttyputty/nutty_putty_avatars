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
  final Person person;

  PersonLoaded(this.person);
  @override
  List<Object> get props => <Object>[person];
}

class PersonError extends PersonState {
  final String message;

  PersonError(this.message);

  @override
  List<Object> get props => <Object>[message];
}
