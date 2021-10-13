// External
import 'package:dots_client/settings/settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';

// Internal
import 'package:dots_client/gen/spot/v1/spot_v1.pbgrpc.dart';
import 'events.dart';
import 'state.dart';

class SpotSettingsPageBloc
    extends Bloc<SpotSettingsPageEvent, SpotSettingsPageState> {
  final AppSettings appSettings;

  final _logger = Logger("SpotSettingsPageBloc");

  SpotSettingsPageBloc({
    required this.appSettings,
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
        final curState = state;
        if (curState is InitedState) {
          emit(CreatingNewSpotState(
            position: curState.position,
            radius: curState.radius,
            scanPeriod: curState.scanPeriod,
            zonePeriod: curState.zonePeriod,
          ));
          final channel = ClientChannel(
            appSettings.environment.host,
            port: appSettings.environment.port,
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

            emit(NewSpotCreatedState(
              spotUuid: response.uuid,
              position: LatLng(
                response.latiitude,
                response.longitude,
              ),
            ));
          } on Exception catch (ex) {
            emit(CreateSpotErrorState(
              position: curState.position,
              radius: curState.radius,
              scanPeriod: curState.scanPeriod,
              zonePeriod: curState.zonePeriod,
              exception: ex,
            ));
          }
          await channel.shutdown();
        } else {}
      },
    );
  }
}
