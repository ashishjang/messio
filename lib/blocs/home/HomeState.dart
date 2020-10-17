import 'package:equatable/equatable.dart';
import 'package:messio/models/Conversation.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState extends Equatable {
  HomeState([List props = const <dynamic>[]]);
}

class InitialHomeState extends HomeState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FetchingHomeChatsState extends HomeState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  @override
  String toString() => 'FetchingHomeChatsState';
}

class FetchedHomeChatsState extends HomeState {
  final List<Conversation> conversations;

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  FetchedHomeChatsState(this.conversations);

  @override
  String toString() => 'FetchedHomeChatsState';
}
