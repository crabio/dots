// External
import 'package:latlong2/latlong.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

// Internal
part 'state.g.dart';

abstract class SpotSettingsPageState {}

// Initial page state
@CopyWith()
class InitedState extends SpotSettingsPageState {
  final LatLng position;
  // Spot radius in meters
  final int zoneRadius;
  final Duration scanPeriod;
  final Duration zonePeriod;

  InitedState({
    required this.position,
    required this.zoneRadius,
    required this.scanPeriod,
    required this.zonePeriod,
  });
}

class CreatingNewSpotState extends SpotSettingsPageState {
  final LatLng position;
  // Spot radius in meters
  final int zoneRadius;
  final Duration scanPeriod;
  final Duration zonePeriod;

  CreatingNewSpotState({
    required this.position,
    required this.zoneRadius,
    required this.scanPeriod,
    required this.zonePeriod,
  });
}

class NewSpotCreatedState extends SpotSettingsPageState {
  final String spotUuid;
  final LatLng position;

  NewSpotCreatedState({
    required this.spotUuid,
    required this.position,
  });
}

class CreateSpotErrorState extends SpotSettingsPageState {
  final LatLng position;
  // Spot radius in meters
  final int zoneRadius;
  final Duration scanPeriod;
  final Duration zonePeriod;
  final Exception exception;

  CreateSpotErrorState({
    required this.position,
    required this.zoneRadius,
    required this.scanPeriod,
    required this.zonePeriod,
    required this.exception,
  });
}
