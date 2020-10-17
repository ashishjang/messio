import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messio/models/User.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const <dynamic>[]]);
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AuthInProgress extends AuthenticationState {
  @override
  String toString() => 'AuthInProgress';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class Authenticated extends AuthenticationState {
  final User user;
  Authenticated(this.user);
  @override
  String toString() => 'Authenticated';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class PreFillData extends AuthenticationState {
  final UserData user;
  PreFillData(this.user);
  @override
  String toString() => 'PreFillData';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UnAuthenticated extends AuthenticationState {
  @override
  String toString() => 'UnAuthenticated';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ReceivedProfilePicture extends AuthenticationState {
  final File file;
  ReceivedProfilePicture(this.file);
  @override
  toString() => 'ReceivedProfilePicture';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ProfileUpdateInProgress extends AuthenticationState {
  @override
  String toString() => 'ProfileUpdateInProgress';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ProfileUpdated extends AuthenticationState {
  @override
  String toString() => 'ProfileComplete';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
