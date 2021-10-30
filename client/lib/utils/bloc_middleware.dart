// External
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

/// Custom [BlocObserver] which observes all bloc and cubit instances.
class BlocObserverLogMiddleware extends BlocObserver {
  final _log = Logger("Bloc");

  @override
  void onEvent(Bloc bloc, Object? event) {
    _log.finer("New ${bloc.runtimeType} ${event.runtimeType}");
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    _log.finer(
        "New ${bloc.runtimeType} transition from ${transition.currentState.runtimeType} to ${transition.nextState.runtimeType} fired by ${transition.event.runtimeType}");
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _log.finer("New Bloc $bloc error: $error");
    super.onError(bloc, error, stackTrace);
  }
}
