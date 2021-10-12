// External
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

// Internal
import 'events.dart';
import 'state.dart';

class SpotSettingsPageBloc
    extends Bloc<SpotSettingsPageEvent, SpotSettingsPageState> {
  final _logger = Logger("SpotSettingsPageBloc");

  SpotSettingsPageBloc({required position})
      : super(InitedState(
          position: position,
          radius: 50,
          scanPeriod: const Duration(seconds: 10),
          zonePeriod: const Duration(seconds: 30),
        )) {
    on<NewRadiusEvent>((event, emit) {
      if (state is InitedState) {
        emit((state as InitedState).copyWith(radius: event.value));
      } else {
        _logger.shout("Not allowed $state for $event");
      }
    });
    on<NewScanDurationEvent>((event, emit) {
      if (state is InitedState) {
        emit((state as InitedState).copyWith(scanPeriod: event.value));
      } else {
        _logger.shout("Not allowed $state for $event");
      }
    });
    on<NewZoneDurationEvent>((event, emit) {
      if (state is InitedState) {
        emit((state as InitedState).copyWith(zonePeriod: event.value));
      } else {
        _logger.shout("Not allowed $state for $event");
      }
    });
  }
}
