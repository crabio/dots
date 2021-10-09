// External
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

/// Custom [BlocObserver] which observes all bloc and cubit instances.
class BlocObserverLogMiddleware extends BlocObserver {
  final log = Logger("Bloc");

  @override
  void onEvent(Bloc bloc, Object? event) {
    log.fine("New Bloc $bloc event: $event");
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log.fine("New Bloc $bloc transition: $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log.fine("New Bloc $bloc error: $error");
    super.onError(bloc, error, stackTrace);
  }
}
