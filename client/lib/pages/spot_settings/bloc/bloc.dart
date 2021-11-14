// External
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';

// Internal
import 'package:dots_client/gen/spot/v1/spot_v1.pbgrpc.dart' as proto;
import 'events.dart';
import 'state.dart';

class SpotSettingsPageBloc
    extends Bloc<SpotSettingsPageEvent, SpotSettingsPageState> {
  final String playerUuid;

  final proto.SpotServiceClient client;

  final _logger = Logger("SpotSettingsPageBloc");

  SpotSettingsPageBloc({
    required this.playerUuid,
    required this.client,
    required position,
  }) : super(InitedState(
          position: position,
          zoneRadius: 50,
          scanPeriod: const Duration(seconds: 10),
          zonePeriod: const Duration(seconds: 30),
          sessionDuration: const Duration(minutes: 2),
          error: "",
        )) {
    on<NewRadiusEvent>((event, emit) {
      if (state is InitedState) {
        emit((state as InitedState).copyWith(zoneRadius: event.value));
      } else {
        _logger.shout("Not allowed $state for $event");
      }
    });
    on<NewScanPeriodEvent>((event, emit) {
      if (state is InitedState) {
        emit((state as InitedState).copyWith(scanPeriod: event.value));
      } else {
        _logger.shout("Not allowed $state for $event");
      }
    });
    on<NewZonePeriodEvent>((event, emit) {
      if (state is InitedState) {
        emit((state as InitedState).copyWith(zonePeriod: event.value));
      } else {
        _logger.shout("Not allowed $state for $event");
      }
    });
    on<NewSessionDurationEvent>((event, emit) {
      if (state is InitedState) {
        emit((state as InitedState).copyWith(zonePeriod: event.value));
      } else {
        _logger.shout("Not allowed $state for $event");
      }
    });

    on<CreateNewSpotEvent>(
      (event, emit) async {
        final curState = state;
        if (curState is InitedState) {
          emit(curState.copyWith(creating: true));
          final request = proto.CreateSpotRequest(
            radiusInM: event.zoneRadius,
            zonePeriodInSeconds: event.zonePeriod.inSeconds,
            scanPeriodInSeconds: event.scanPeriod.inSeconds,
            position: proto.Position(
              latitude: event.position.latitude,
              longitude: event.position.longitude,
            ),
          );
          final response = await client.createSpot(request);

          // Join to spot
          await client
              .joinToSpot(proto.JoinToSpotRequest(
                spotUuid: response.spotUuid,
                playerUuid: playerUuid,
              ))
              .then(
                (jtsResponse) => emit(NewSpotCreatedState(
                  spotUuid: response.spotUuid,
                  position: LatLng(
                    event.position.latitude,
                    event.position.longitude,
                  ),
                )),
                onError: (error) => emit(curState.copyWith(
                  creating: false,
                  error: error.toString(),
                )),
              );
        } else {
          _logger.shout("Not allowed $state for $event");
        }
      },
    );
  }
}
