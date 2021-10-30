import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class SpotSettingsPageEvent extends Equatable {
  const SpotSettingsPageEvent();

  @override
  List<Object> get props => [];
}

class NewRadiusEvent extends SpotSettingsPageEvent {
  final double value;

  const NewRadiusEvent({required this.value});

  @override
  List<Object> get props => [value];
}

class NewScanDurationEvent extends SpotSettingsPageEvent {
  final Duration value;

  const NewScanDurationEvent({required this.value});

  @override
  List<Object> get props => [value];
}

class NewZoneDurationEvent extends SpotSettingsPageEvent {
  final Duration value;

  const NewZoneDurationEvent({required this.value});

  @override
  List<Object> get props => [value];
}

class CreateNewSpotEvent extends SpotSettingsPageEvent {
  final LatLng position;
  // Spot radius in meters
  final double zoneRadius;
  final Duration scanPeriod;
  final Duration zonePeriod;

  const CreateNewSpotEvent({
    required this.position,
    required this.zoneRadius,
    required this.scanPeriod,
    required this.zonePeriod,
  });

  @override
  List<Object> get props => [
        position,
        zoneRadius,
        scanPeriod,
        zonePeriod,
      ];
}
