// import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nutty_putty_avatars/models/avatar.dart';

@immutable
abstract class AvatarState extends Equatable {
  const AvatarState();

  @override
  List<Object> get props => <Object>[];
}

class AvatarInitial extends AvatarState {}

class AvatarLoading extends AvatarState {}

class AvatarLoaded extends AvatarState {
  final Avatar avatars;

  AvatarLoaded(this.avatars);
  @override
  List<Object> get props => <Object>[avatars];
}

class AvatarError extends AvatarState {
  final String message;

  AvatarError(this.message);

  @override
  List<Object> get props => <Object>[message];
}
