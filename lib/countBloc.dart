import 'package:messio/countState.dart';
import 'package:messio/counterEvent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class CountBloc extends Bloc<CounterEvent, CountState> {
  CountBloc(CountState initialState) : super(initialState);
  @override
  Stream<CountState> mapEventToState(CounterEvent event) async* {
    final _currentState = CountState(count: 0);
    if (event is IncrementEvent) {
      yield CountState(count: _currentState.count + 1);
    } else if (event is DecrementEvent) {
      yield CountState(count: _currentState.count - 1);
    }
  }

  @override
  // TODO: implement initialState
  CountState get initialState => throw CountState.initial();
}
