import 'package:equatable/equatable.dart';
import 'package:messio/models/Contact.dart';
import 'package:messio/utils/Exceptions.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ContactsState extends Equatable {
  ContactsState([List props = const <dynamic>[]]);
}

class InitialContactsState extends ContactsState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  @override
  String toString() => 'InitialContactsState';
}

//Fetching contacts from firebase
class FetchingContactsState extends ContactsState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  @override
  String toString() => 'FetchingContactsState';
}

//contacts fetched successfully
class FetchedContactsState extends ContactsState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  final List<Contact> contacts;
  FetchedContactsState(this.contacts) : super([contacts]);
  @override
  String toString() => 'FetchedContactsState';
}

// Add Contact Clicked, show progressbar
class AddContactProgressState extends ContactsState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  @override
  String toString() => 'AddContactProgressState';
}

// Add contact success
class AddContactSuccessState extends ContactsState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  @override
  String toString() => 'AddContactSuccessState';
}

// Add contact failed
class AddContactFailedState extends ContactsState {
  final MessioException exception;

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  AddContactFailedState(this.exception) : super([exception]);
  @override
  String toString() => 'AddContactFailedState';
}

// Handle errors
class ErrorState extends ContactsState {
  final MessioException exception;
  ErrorState(this.exception) : super([exception]);
  @override
  String toString() => 'ErrorState';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
