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

class NewScanPeriodEvent extends SpotSettingsPageEvent {
  final Duration value;

  const NewScanPeriodEvent({required this.value});

  @override
  List<Object> get props => [value];
}

class NewZonePeriodEvent extends SpotSettingsPageEvent {
  final Duration value;

  const NewZonePeriodEvent({required this.value});

  @override
  List<Object> get props => [value];
}

class NewSessionDurationEvent extends SpotSettingsPageEvent {
  final Duration value;

  const NewSessionDurationEvent({required this.value});

  @override
  List<Object> get props => [value];
}

class CreateNewSpotEvent extends SpotSettingsPageEvent {
  final LatLng position;
  // Spot radius in meters
  final double zoneRadius;
  final Duration scanPeriod;
  final Duration zonePeriod;
  final Duration sessionDuration;

  const CreateNewSpotEvent({
    required this.position,
    required this.zoneRadius,
    required this.scanPeriod,
    required this.zonePeriod,
    required this.sessionDuration,
  });

  @override
  List<Object> get props => [
        position,
        zoneRadius,
        scanPeriod,
        zonePeriod,
        sessionDuration,
      ];
}
