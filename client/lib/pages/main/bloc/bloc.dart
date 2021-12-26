// External
import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';

// Internal
import 'events.dart';
import 'state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final GeolocatorPlatform geolocator;
  late StreamSubscription<Position>? _geoPositionSub;

  final _logger = Logger("MainPageBloc");

  MainPageBloc({
    required this.geolocator,
  }) : super(InitingState()) {
    on<InitEvent>(_onInitEvent);
    on<NewGeoPositionEvent>(_onNewGeoPositionEvent);

    add(InitEvent());
  }

  @override
  Future<void> close() {
    if (_geoPositionSub != null) {
      _geoPositionSub!.cancel();
    }

    return super.close();
  }

  void _onInitEvent(
    InitEvent event,
    Emitter<MainPageState> emit,
  ) async {
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
    _geoPositionSub = geolocator
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
