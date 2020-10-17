import 'package:equatable/equatable.dart';
import 'package:messio/models/Contact.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ContactsEvent extends Equatable {
  ContactsEvent([List props = const <dynamic>[]]);
}

// Fetch the contacts from firebase
class FetchContactsEvent extends ContactsEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  @override
  String toString() => 'FetchContactsEvent';
}

// Dispatch received contacts from stream
class ReceivedContactsEvent extends ContactsEvent {
  final List<Contact> contacts;

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  ReceivedContactsEvent(this.contacts) : super([contacts]);
  @override
  String toString() => 'ReceivedContactsEvent';
}

//Add a new contact
class AddContactEvent extends ContactsEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  final String username;
  AddContactEvent({@required this.username}) : super([username]);
  @override
  String toString() => 'AddContactEvent';
}
