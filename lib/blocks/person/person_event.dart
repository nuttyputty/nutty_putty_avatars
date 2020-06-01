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
  final Person initialPerson;

  InitialPerson(this.initialPerson);

  @override
  List<Object> get props => [initialPerson];
}
