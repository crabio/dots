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
