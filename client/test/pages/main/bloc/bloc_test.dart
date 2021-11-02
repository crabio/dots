// External
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

// Internal
import 'package:dots_client/pages/main/bloc/events.dart';
import 'package:dots_client/pages/main/bloc/bloc.dart';
import 'package:dots_client/pages/main/bloc/state.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'bloc_test.mocks.dart';

@GenerateMocks([GeolocatorPlatform])
void main() {
  group('MainPageBloc', () {
    final geolocator = MockGeolocatorPlatform();
    // Stub a mock methods before interacting.
    when(geolocator.requestPermission())
        .thenAnswer((_) async => LocationPermission.always);
    when(geolocator.getLastKnownPosition()).thenAnswer((_) async => Position(
          longitude: 10,
          latitude: 20,
          timestamp: DateTime.now(),
          accuracy: 5,
          altitude: 200,
          heading: 0.1,
          speed: 5,
          speedAccuracy: 0.1,
        ));
    when(geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 0,
      forceAndroidLocationManager: false,
      timeInterval: 0,
      timeLimit: null,
    )).thenAnswer((_) => Stream.fromIterable([
          Position(
            longitude: 10,
            latitude: 20,
            timestamp: DateTime.now(),
            accuracy: 5,
            altitude: 200,
            heading: 0.1,
            speed: 5,
            speedAccuracy: 0.1,
          )
        ]));

    blocTest<MainPageBloc, MainPageState>(
      'emits [MainPageState] on init.',
      build: () => MainPageBloc(
        geolocator: geolocator,
      ),
      expect: () => <MainPageState>[],
    );
    blocTest<MainPageBloc, MainPageState>(
      'emits [MainPageState] when InitEvent is added.',
      build: () => MainPageBloc(
        geolocator: geolocator,
      ),
      act: (bloc) => bloc.add(InitEvent()),
      expect: () => <MainPageState>[],
    );
    blocTest<MainPageBloc, MainPageState>(
      'emits [InitedState] when NewGeoPositionEvent is added.',
      build: () => MainPageBloc(
        geolocator: geolocator,
      ),
      act: (bloc) => bloc.add(NewGeoPositionEvent(position: LatLng(60, 10))),
      expect: () => <MainPageState>[
        InitedState(position: LatLng(60, 10)),
      ],
    );
  });
}
