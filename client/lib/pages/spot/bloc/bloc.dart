// External
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';

// Internal
import 'package:dots_client/gen/spot/v1/spot_v1.pbgrpc.dart' as proto;
import 'package:uuid/uuid.dart';
import 'events.dart';
import 'state.dart';

class SpotPageBloc extends Bloc<SpotPageEvent, SpotPageState> {
  final proto.SpotServiceClient client;
  final GeolocatorPlatform geolocator;
  final String spotUuid;
  final String playerUuid = const Uuid().v4();

  final _logger = Logger("SpotPageBloc");

  SpotPageBloc({
    required this.client,
    required this.geolocator,
    required this.spotUuid,
  }) : super(InitingState()) {
    on<InitEvent>(_onInitEvent);
    on<NewGeoPositionEvent>(_onNewGeoPositionEvent);

    add(InitEvent());
  }

  void _onInitEvent(InitEvent event, Emitter<SpotPageState> emit) async {
    _logger.fine("Get spot data");

    final playerPosition = await geolocator.getLastKnownPosition();

    final getSpotResponse = await _getSpotData();
    getSpotResponse.fold(
        (l) => emit(InitErrorState(exception: l)),
        (r) => emit(InitedState(
              playerPosition: LatLng(
                playerPosition!.latitude,
                playerPosition.longitude,
              ),
              spotPosition: LatLng(
                r.position.latitude,
                r.position.longitude,
              ),
              zoneRadius: r.radius,
              scanPeriod: Duration(seconds: r.scanPeriodInSeconds),
              zonePeriod: Duration(seconds: r.zonePeriodInSeconds),
            )));

    _logger.fine("Subscribe on location");
    _subscribeOnGeoPosition().fold(
      (l) => emit(InitErrorState(exception: l)),
      (r) => null,
    );
  }

  Stream<proto.SendPlayerPositionRequest> _createPlayerPositionStream(
      Stream<Position> stream) async* {
    await for (final position in stream) {
      yield proto.SendPlayerPositionRequest(
        spotUuid: spotUuid,
        playerUuid: playerUuid,
        position: proto.Position(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );
    }
  }

  Future<Either<Exception, proto.GetSpotResponse>> _getSpotData() async {
    final request = proto.GetSpotRequest(spotUuid: spotUuid);
    try {
      return Right(await client.getSpot(request));
    } on Exception catch (ex) {
      return Left(ex);
    }
  }

  Either<Exception, bool> _subscribeOnGeoPosition() {
    final positionStream = geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
    );

    try {
      client.sendPlayerPosition(_createPlayerPositionStream(positionStream));
    } on Exception catch (ex) {
      return Left(ex);
    }

    positionStream.listen((position) => add(NewGeoPositionEvent(
            position: LatLng(
          position.latitude,
          position.longitude,
        ))));

    return const Right(true);
  }

  void _onNewGeoPositionEvent(
      NewGeoPositionEvent event, Emitter<SpotPageState> emit) async {
    final curState = state;
    if (curState is InitedState) {
      emit(curState.copyWith(playerPosition: event.position));
    }
  }
}
