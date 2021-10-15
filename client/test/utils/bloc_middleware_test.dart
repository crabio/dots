// External
import 'package:dots_client/utils/bloc_middleware.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

// Internal

void main() {
  test('Test Bloc middleware', () {
    final observer = BlocObserverLogMiddleware();
    final bloc = _Bloc();

    observer.onEvent(
      bloc,
      _InitEvent(),
    );
    observer.onTransition(
      bloc,
      Transition(
        currentState: _InitingState(),
        event: _InitEvent(),
        nextState: _InitedState(),
      ),
    );
    observer.onError(
      bloc,
      "test error",
      StackTrace.current,
    );
  });
}

abstract class _Event {}

class _InitEvent extends _Event {}

abstract class _State {}

class _InitingState extends _State {}

class _InitedState extends _State {}

class _Bloc extends Bloc<_Event, _State> {
  _Bloc() : super(_InitingState()) {
    on<_InitEvent>((event, emit) {
      emit(_InitedState());
    });
  }
}
