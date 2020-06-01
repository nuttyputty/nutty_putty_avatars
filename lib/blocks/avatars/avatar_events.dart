import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AvatarEvents extends Equatable {
  const AvatarEvents();

  @override
  List<Object> get props => <dynamic>[];
}

class GetAvatars extends AvatarEvents {
  GetAvatars();

  @override
  List<Object> get props => [];
}
