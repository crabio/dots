// External
import 'package:dartz/dartz.dart';
import 'package:dots_client/pages/spot/resources/player_position.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grpc/grpc.dart';
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';

// Internal
import 'package:dots_client/gen/spot/v1/spot_v1.pbgrpc.dart' as proto;
import 'events.dart';
import 'state.dart';

class SpotPageBloc extends Bloc<SpotPageEvent, SpotPageState> {
  final proto.SpotServiceClient client;
  final GeolocatorPlatform geolocator;
  final String spotUuid;
  final String playerUuid;

  final _logger = Logger("SpotPageBloc");

  SpotPageBloc({
    required this.client,
    required this.geolocator,
    required this.spotUuid,
    required this.playerUuid,
  }) : super(InitingState()) {
    on<InitEvent>(_onInitEvent);
    on<NewSpotPlayersListEvent>(_onNewSpotPlayersListEvent);
    on<NewPlayersStatesEvent>(_onNewPlayersStatesEvent);
    on<StartGameEvent>(_onStartGameEvent);

    add(InitEvent());
  }

  void _onInitEvent(InitEvent event, Emitter<SpotPageState> emit) async {
    _logger.fine("Get spot data");

    final getSpotResponse = await _getSpotData();
    final spotData = getSpotResponse.fold(
      (l) {
        emit(InitErrorState(exception: l));
        return null;
      },
      (r) => r,
    );
    if (getSpotResponse.isLeft()) {
      return;
    }

    // _logger.fine("Subscribe on geo position");
    // _subscribeOnGeoPosition().fold(
    //   (l) => emit(InitErrorState(exception: l)),
    //   (r) => null,
    // );

    _logger.fine("Subscribe on players list");
    _subscribeOnSpotPlayers().fold(
      (l) => emit(InitErrorState(exception: l)),
      (r) => r.listen((value) {
        add(NewSpotPlayersListEvent(playersList: value.playersList));
      }),
    );

    _logger.fine("Subscribe on spot active state");
    _subscribeOnSpotStartFlag().fold(
      (l) => emit(InitErrorState(exception: l)),
      (r) => r.listen((value) {
        emit(ActiveState(
          spotPosition: LatLng(
            spotData!.position.latitude,
            spotData.position.longitude,
          ),
          otherPlayersStates: const {},
        ));
      }),
    );

    // _logger.fine("Subscribe on players states");
    // _subscribeOnPlayersStates().fold(
    //   (l) => emit(InitErrorState(exception: l)),
    //   (r) => r.listen((value) => add(NewPlayersStatesEvent(
    //         playerUuid: value.playerState.playerUuid,
    //         playerPosition: LatLng(
    //           value.playerState.position.latitude,
    //           value.playerState.position.longitude,
    //         ),
    //         playerHealth: value.playerState.health,
    //       ))),
    // );
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

    return const Right(true);
  }

  Either<Exception, ResponseStream<proto.GetSpotPlayersResponse>>
      _subscribeOnSpotPlayers() {
    try {
      final request = proto.GetSpotPlayersRequest(spotUuid: spotUuid);

      return Right(client.getSpotPlayers(request));
    } on Exception catch (ex) {
      return Left(ex);
    }
  }

  Either<Exception, ResponseStream<proto.GetSpotStartFlagResponse>>
      _subscribeOnSpotStartFlag() {
    try {
      return Right(client.getSpotStartFlag(proto.GetSpotStartFlagRequest(
        spotUuid: spotUuid,
      )));
    } on Exception catch (ex) {
      return Left(ex);
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

  void _onNewSpotPlayersListEvent(
    NewSpotPlayersListEvent event,
    Emitter<SpotPageState> emit,
  ) async {
    final curState = state;
    if (curState is IdleState) {
      emit(IdleState(playersList: event.playersList));
    }
  }

  void _onStartGameEvent(
    StartGameEvent event,
    Emitter<SpotPageState> emit,
  ) async {
    final curState = state;
    if (curState is IdleState) {
      try {
        client.startSpot(proto.StartSpotRequest(spotUuid: spotUuid));
      } on Exception catch (ex) {
        emit(curState.copyWith(exception: ex));
      }
    } else {
      _logger.shout("Wrong state $curState for $event");
    }
  }

  void _onNewPlayersStatesEvent(
    NewPlayersStatesEvent event,
    Emitter<SpotPageState> emit,
  ) async {
    final curState = state;
    if (curState is ActiveState) {
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
