// External
import 'package:geolocator/geolocator.dart';

Future<void> requestPermissions() async {
  LocationPermission permission = await Geolocator.requestPermission();
  if (permission != LocationPermission.always &&
      permission != LocationPermission.whileInUse) {
    throw Exception("Location permission is not granded");
  }
}
