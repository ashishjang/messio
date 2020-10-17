import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ConfigEvent extends Equatable {
  ConfigEvent([List props = const <dynamic>[]]);
}

class ConfigValueChanged extends ConfigEvent {
  final String key;
  final bool value;
  ConfigValueChanged(this.key, this.value) : super([key, value]);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UpdateProfilePicture extends ConfigEvent {
  final File file;
  UpdateProfilePicture(this.file) : super([file]);
  @override
  String toString() => 'UpdateProfilePicture';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RestartApp extends ConfigEvent {
  @override
  String toString() => 'RestartApp';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
