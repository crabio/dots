import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dots_client/pages/game/resources/player_position.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grpc/grpc.dart';
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import 'package:dots_client/gen/spot/v1/spot_v1.pbgrpc.dart' as proto;
part 'event.dart';
part 'state.dart';
part 'bloc.g.dart';

class GamePageBloc extends Bloc<GamePageEvent, GamePageState> {
  final proto.SpotServiceClient client;
  final GeolocatorPlatform geolocator;
  final String spotUuid;
  final String playerUuid;

  final _logger = Logger("SpotPageBloc");

  GamePageBloc({
    required this.client,
    required this.geolocator,
    required this.spotUuid,
    required this.playerUuid,
  }) : super(GamePageInitial()) {
    on<InitEvent>(_onInitEvent);
    on<NewPlayersStatesEvent>(_onNewPlayersStatesEvent);
  }

  void _onInitEvent(InitEvent event, Emitter<GamePageState> emit) async {
    _logger.fine("Get spot data");
    final spotData = await _getSpotData().then((value) => value.fold(
          (l) {
            emit(ErrorState(exception: l));
            return null;
          },
          (r) => r,
        ));
    if (spotData == null) {
      return;
    }

    _logger.fine("Get last player known geo position");
    final lastKnownPlayerPos = await geolocator.getLastKnownPosition();
    if (lastKnownPlayerPos == null) {
      emit(ErrorState(
          exception: Exception("Couldn't get last known player pos")));
    }
    emit(InitedState(
      playerState: PlayerState(
        position: LatLng(
          lastKnownPlayerPos!.latitude,
          lastKnownPlayerPos.longitude,
        ),
        health: 100,
      ),
      otherPlayersStates: const {},
      spotPosition: LatLng(
        spotData.position.latitude,
        spotData.position.longitude,
      ),
      zoneRadius: spotData.radius,
    ));

    _logger.fine("Subscribe on geo position");
    _subscribeOnGeoPosition().fold(
      (l) => emit(ErrorState(exception: l)),
      (r) => null,
    );

    _logger.fine("Subscribe on players states");
    _subscribeOnPlayersStates().fold(
      (l) => emit(ErrorState(exception: l)),
      (r) => r.listen((value) => add(NewPlayersStatesEvent(
            playerUuid: value.playerState.playerUuid,
            playerPosition: LatLng(
              value.playerState.position.latitude,
              value.playerState.position.longitude,
            ),
            playerHealth: value.playerState.health,
          ))),
    );
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

    return const Right(true);
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

  Either<Exception, ResponseStream<proto.GetPlayersStatesResponse>>
      _subscribeOnPlayersStates() {
    try {
      final request = proto.GetPlayersStatesRequest(
        spotUuid: spotUuid,
        playerUuid: playerUuid,
      );

      return Right(client.getPlayersStates(request));
    } on Exception catch (ex) {
      return Left(ex);
    }
  }

  void _onNewPlayersStatesEvent(
    NewPlayersStatesEvent event,
    Emitter<GamePageState> emit,
  ) async {
    final curState = state;
    if (curState is InitedState) {
      if (event.playerUuid == playerUuid) {
        // Update this player state
        emit(curState.copyWith(
          playerState: PlayerState(
            position: event.playerPosition,
            health: event.playerHealth,
          ),
        ));
      } else {
        // Update another player state
        final otherPlayersStates = Map.of(curState.otherPlayersStates);
        otherPlayersStates[event.playerUuid] = PlayerState(
          position: event.playerPosition,
          health: event.playerHealth,
        );
        emit(curState.copyWith(otherPlayersStates: otherPlayersStates));
      }
    } else {
      _logger.shout("Wrong state $curState for $event");
    }
  }
}