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
  final int radius;
  final Duration scanPeriod;
  final Duration zonePeriod;

  InitedState({
    required this.position,
    required this.radius,
    required this.scanPeriod,
    required this.zonePeriod,
  });
}
