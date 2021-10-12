import 'package:latlong2/latlong.dart';

abstract class SpotSettingsPageEvent {}

class NewRadiusEvent extends SpotSettingsPageEvent {
  final int value;

  NewRadiusEvent({required this.value});
}

class NewScanDurationEvent extends SpotSettingsPageEvent {
  final Duration value;

  NewScanDurationEvent({required this.value});
}

class NewZoneDurationEvent extends SpotSettingsPageEvent {
  final Duration value;

  NewZoneDurationEvent({required this.value});
}

class CreateNewSpotEvent extends SpotSettingsPageEvent {
  final LatLng position;
  // Spot radius in meters
  final int radius;
  final Duration scanPeriod;
  final Duration zonePeriod;

  CreateNewSpotEvent({
    required this.position,
    required this.radius,
    required this.scanPeriod,
    required this.zonePeriod,
  });
}
