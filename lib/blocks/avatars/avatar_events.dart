import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nutty_putty_avatars/models/part.dart';

@immutable
abstract class AvatarEvents extends Equatable {
  const AvatarEvents();

  @override
  List<Object> get props => <dynamic>[];
}

class GetAvatars extends AvatarEvents {
  GetAvatars({this.isStaging});
  bool isStaging;
  @override
  List<Object> get props => [isStaging];
}

class GeneratePartsList extends AvatarEvents {
  final List<AvatarPart> parts;
  GeneratePartsList(this.parts);

  @override
  List<Object> get props => [parts];
}
