// External
import 'package:flutter_bloc/flutter_bloc.dart';

// Internal
import 'events.dart';
import 'state.dart';

/// {@template counter_bloc}
/// A simple [Bloc] which manages an `int` as its state.
/// {@endtemplate}
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  /// {@macro counter_bloc}
  CounterBloc() : super(InitedState(count: 0)) {
    on<Increment>((event, emit) => emit(InitedState(count: state.count + 1)));
    on<Decrement>((event, emit) => emit(InitedState(count: state.count - 1)));
  }
}
