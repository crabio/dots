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

    add(InitEvent());
  }

  void _onInitEvent(InitEvent event, Emitter<LobbyPageState> emit) async {
    _logger.fine("Get spot data");

    _logger.fine("Subscribe on players list");
    _subscribeOnSpotPlayers().fold(
      (l) => emit(InitErrorState(exception: l)),
      (r) => r.listen((value) {
        add(NewSpotPlayersListEvent(playersList: value.playersList));
      }),
    );

    if (!isHost) {
      _logger.fine("Subscribe on spot active state");
      _subscribeOnSpotStartFlag().fold(
        (l) => emit(InitErrorState(exception: l)),
        (r) => r.listen((value) {
          if (value.isActive) {
            emit(GoToGameState());
          } else {
            throw Exception("Unimplemented");
          }
        }),
      );
    }
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

  void _onNewSpotPlayersListEvent(
    NewSpotPlayersListEvent event,
    Emitter<LobbyPageState> emit,
  ) async {
    emit(InitedState(playersList: event.playersList));
  }

  void _onStartGameEvent(
    StartGameEvent event,
    Emitter<LobbyPageState> emit,
  ) async {
    final curState = state;
    if (curState is InitedState) {
      try {
        client.startSpot(proto.StartSpotRequest(spotUuid: spotUuid));

        emit(GoToGameState());
      } on Exception catch (ex) {
        emit(InitErrorState(exception: ex));
      }
    } else {
      _logger.shout("Wrong state $curState for $event");
    }
  }
}
