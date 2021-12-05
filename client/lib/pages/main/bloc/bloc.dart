// External
import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';

// Internal
import 'events.dart';
import 'state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final GeolocatorPlatform geolocator;

  final _logger = Logger("MainPageBloc");

  MainPageBloc({
    required this.geolocator,
  }) : super(InitingState()) {
    on<InitEvent>(_onInitEvent);
    on<NewGeoPositionEvent>(_onNewGeoPositionEvent);

    add(InitEvent());
  }

  void _onInitEvent(
    InitEvent event,
    Emitter<MainPageState> emit,
  ) async {
    _logger.fine("Check geolocation permission");
    LocationPermission permission = await geolocator.checkPermission();
    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      emit(LocationsPermissionIsNotAllowedState());
    }

    _logger.fine("Get last known position");
    final position = await geolocator.getLastKnownPosition();
    if (position != null) {
      emit(InitedState(
        position: LatLng(
          position.latitude,
          position.longitude,
        ),
      ));
    } else {
      emit(CouldntGetPositionState());
    }

    _logger.fine("Subscribe on location");
    geolocator
        .getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
          ),
        )
        .listen((position) => add(NewGeoPositionEvent(
                position: LatLng(
              position.latitude,
              position.longitude,
            ))));
  }

  void _onNewGeoPositionEvent(
    NewGeoPositionEvent event,
    Emitter<MainPageState> emit,
  ) async {
    emit(InitedState(position: event.position));
  }
}
