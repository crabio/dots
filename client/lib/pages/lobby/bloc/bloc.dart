// External
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grpc/grpc.dart';
import 'package:logging/logging.dart';

// Internal
import 'package:dots_client/gen/spot/v1/spot_v1.pbgrpc.dart' as proto;

part 'events.dart';
part 'state.dart';

class LobbyPageBloc extends Bloc<LobbyPageEvent, LobbyPageState> {
  final proto.SpotServiceClient client;
  final GeolocatorPlatform geolocator;
  final String spotUuid;
  final String playerUuid;
  final bool isHost;

  late ResponseStream<proto.GetSpotPlayersResponse> _playersListSub;

  final _logger = Logger("LobbyPageBloc");

  LobbyPageBloc({
    required this.client,
    required this.geolocator,
    required this.spotUuid,
    required this.playerUuid,
    required this.isHost,
  }) : super(InitingState()) {
    on<InitEvent>(_onInitEvent);
    on<NewSpotPlayersListEvent>(_onNewSpotPlayersListEvent);
    on<StartGameEvent>(_onStartGameEvent);
    on<LeaveSpotEvent>(_onLeaveSpotEvent);

    add(const InitEvent());
  }

  Future<void> _onInitEvent(
    InitEvent event,
    Emitter<LobbyPageState> emit,
  ) async {
    _logger.fine("Get spot data");

    _logger.fine("Subscribe on players list");
    _playersListSub =
        client.getSpotPlayers(proto.GetSpotPlayersRequest(spotUuid: spotUuid));
    _playersListSub.listen(
      (value) => add(NewSpotPlayersListEvent(playersList: value.playersList)),
      onError: (error, stackTrace) {
        final grpcError = cast<GrpcError>(error);
        if (grpcError.code != StatusCode.cancelled) {
          emit(ErrorState(exception: error));
        }
      },
    );

    if (!isHost) {
      _logger.fine("Subscribe on spot active state");
      client.subGameEvent(proto.SubGameEventRequest(spotUuid: spotUuid)).listen(
        (value) async {
          switch (value.whichEvent()) {
            case proto.SubGameEventResponse_Event.startGameEvent:
              _logger.fine("Session was started");
              await client
                  .isPlayerHunter(proto.IsPlayerHunterRequest(
                    spotUuid: spotUuid,
                    playerUuid: playerUuid,
                  ))
                  .then(
                    (response) =>
                        emit(GoToGameState(isHunter: response.isHunter)),
                    onError: (error) => emit(ErrorState(exception: error)),
                  );
              break;

            case proto.SubGameEventResponse_Event.stopGameEvent:
              _logger.fine("Session is stopped");
              break;

            default:
          }
        },
        onError: (error) => emit(ErrorState(exception: error)),
      );
    }
  }

  Future<void> _onNewSpotPlayersListEvent(
    NewSpotPlayersListEvent event,
    Emitter<LobbyPageState> emit,
  ) async {
    emit(InitedState(playersList: event.playersList));
  }

  Future<void> _onStartGameEvent(
    StartGameEvent event,
    Emitter<LobbyPageState> emit,
  ) async {
    final curState = state;
    if (curState is InitedState) {
      await client.startSpot(proto.StartSpotRequest(spotUuid: spotUuid)).then(
            (response) => null,
            onError: (error) => emit(ErrorState(exception: error)),
          );

      await client
          .isPlayerHunter(proto.IsPlayerHunterRequest(
            spotUuid: spotUuid,
            playerUuid: playerUuid,
          ))
          .then(
            (response) => emit(GoToGameState(isHunter: response.isHunter)),
            onError: (error) => emit(ErrorState(exception: error)),
          );
    } else {
      _logger.shout("Wrong state $curState for $event");
    }
  }

  Future<void> _onLeaveSpotEvent(
    LeaveSpotEvent event,
    Emitter<LobbyPageState> emit,
  ) async {
    // Cancel player list subscription to prevent states overriding
    _playersListSub.cancel();
    await client
        .leaveSpot(proto.LeaveSpotRequest(
      spotUuid: spotUuid,
      playerUuid: playerUuid,
    ))
        .then(
      (response) => emit(const LeavingSpotState()),
      onError: (error) async {
        emit(ErrorState(exception: error));
        // Go to main page after time
        await Future.delayed(
          const Duration(seconds: 10),
          () => emit(const LeavingSpotState()),
        );
      },
    );
  }
}
