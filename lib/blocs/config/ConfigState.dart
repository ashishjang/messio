import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ConfigState extends Equatable {
  ConfigState([List props = const <dynamic>[]]);
}

class ConfigChangeState extends ConfigState {
  final String key;
  final bool value;
  ConfigChangeState(this.key, this.value) : super([key, value]);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UnConfigState extends ConfigState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UpdatingProfilePictureState extends ConfigState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ProfilePictureChangedState extends ConfigState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  final String profilePictureUrl;
  ProfilePictureChangedState(this.profilePictureUrl)
      : super([profilePictureUrl]);
  @override
  String toString() =>
      'ProfilePictureChangedState {profilePictureUrl: $profilePictureUrl}';
}

class RestartedAppState extends ConfigState {
  RestartedAppState() : super([]);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
