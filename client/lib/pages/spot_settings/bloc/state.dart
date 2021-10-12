// External
import 'package:latlong2/latlong.dart';

abstract class SpotSettingsPageState {}

// Initial page state
class InitedState extends SpotSettingsPageState {
  final LatLng position;

  InitedState({required this.position});
}
