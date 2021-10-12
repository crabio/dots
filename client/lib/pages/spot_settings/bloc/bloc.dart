// External
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:grpc/grpc.dart';
import 'package:logging/logging.dart';

// Internal
import 'package:dots_client/gen/spot/v1/spot_v1.pbgrpc.dart';
import 'events.dart';
import 'state.dart';

class SpotSettingsPageBloc
    extends Bloc<SpotSettingsPageEvent, SpotSettingsPageState> {
  final _logger = Logger("SpotSettingsPageBloc");

  SpotSettingsPageBloc({
    required position,
  }) : super(InitedState(
          position: position,
          radius: 50,
          scanPeriod: const Duration(seconds: 10),
          zonePeriod: const Duration(seconds: 30),
        )) {
    on<NewRadiusEvent>((event, emit) {
      if (state is InitedState) {
        emit((state as InitedState).copyWith(radius: event.value));
      } else {
        _logger.shout("Not allowed $state for $event");
      }
    });
    on<NewScanDurationEvent>((event, emit) {
      if (state is InitedState) {
        emit((state as InitedState).copyWith(scanPeriod: event.value));
      } else {
        _logger.shout("Not allowed $state for $event");
      }
    });
    on<NewZoneDurationEvent>((event, emit) {
      if (state is InitedState) {
        emit((state as InitedState).copyWith(zonePeriod: event.value));
      } else {
        _logger.shout("Not allowed $state for $event");
      }
    });

    on<CreateNewSpotEvent>(
      (event, emit) async {
        emit(CreatingNewSpotState());
        // Send reques to host

        final channel = ClientChannel(
          settings.environment.host,
          port: settings.environment.port,
          options: const ChannelOptions(
            credentials: ChannelCredentials.insecure(),
          ),
        );

        final stub = SpotServiceClient(channel);
        final request = CreateSpotRequest(
          longitude: event.position.longitude,
          latiitude: event.position.latitude,
        );
        try {
          final response = await stub.createSpot(request);

          add(NewSpotCreatedEvent(
            spotUuid: response.uuid,
            position: LatLng(
              response.latiitude,
              response.longitude,
            ),
          ));
        } catch (ex) {
          emit(CreateSpotErrorState(error: ex.toString()));
        }

        await channel.shutdown();
      },
    );
    on<NewSpotCreatedEvent>(
      (event, emit) => emit(
        NewSpotCreatedState(
          spotUuid: event.spotUuid,
          position: event.position,
        ),
      ),
    );
  }
}
