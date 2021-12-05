import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:dots_client/gen/spot/v1/spot_v1.pbgrpc.dart' as proto;
part 'events.dart';
part 'state.dart';
part 'bloc.g.dart';

class JoinSpotPageBloc extends Bloc<JoinSpotPageEvent, JoinSpotPageState> {
  final proto.SpotServiceClient client;
  final String playerUuid;

  JoinSpotPageBloc({
    required this.client,
    required this.playerUuid,
  }) : super(const JoinSpotPageInitial(spotUuid: "", error: "")) {
    on<NewSpotUuidEvent>((event, emit) =>
        emit(JoinSpotPageInitial(spotUuid: event.spotUuid, error: "")));
    on<JoinSpotEvent>(_onJoinSpotEvent);
  }

  Future<void> _onJoinSpotEvent(
    JoinSpotEvent event,
    Emitter<JoinSpotPageState> emit,
  ) async {
    final curState = state;
    if (curState is JoinSpotPageInitial) {
      await client
          .joinToSpot(proto.JoinToSpotRequest(
            spotUuid: event.spotUuid,
            playerUuid: playerUuid,
          ))
          .then(
            (response) => emit(JoinedSpotState(spotUuid: event.spotUuid)),
            onError: (grpcError) =>
                emit(curState.copyWith(error: grpcError.toString())),
          );
    }
  }
}
