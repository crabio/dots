import 'dart:developer';

/// State being processed by [CounterBloc].
abstract class CounterState {
  final int count;

  CounterState({required this.count});
}

/// Inited state
class InitedState extends CounterState {
  InitedState({required count}) : super(count: count);
}
