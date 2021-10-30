// External
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

// Internal
part 'state.g.dart';

abstract class SpotSettingsPageState extends Equatable {
  const SpotSettingsPageState();

  @override
  List<Object?> get props => [];
}

// Initial page state
@CopyWith()
class InitedState extends SpotSettingsPageState {
  final LatLng position;
  // Spot radius in meters
  final double zoneRadius;
  final Duration scanPeriod;
  final Duration zonePeriod;
  final bool creating;
  final Exception? exception;

  const InitedState({
    required this.position,
    required this.zoneRadius,
    required this.scanPeriod,
    required this.zonePeriod,
    this.creating = false,
    this.exception,
  });

  @override
  List<Object?> get props => [
        position,
        zoneRadius,
        scanPeriod,
        zonePeriod,
        creating,
        exception,
      ];
}

class NewSpotCreatedState extends SpotSettingsPageState {
  final String spotUuid;
  final LatLng position;

  const NewSpotCreatedState({
    required this.spotUuid,
    required this.position,
  });

  @override
  List<Object> get props => [
        spotUuid,
        position,
      ];
}
