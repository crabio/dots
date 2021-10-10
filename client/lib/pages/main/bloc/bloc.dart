// External
import 'package:dots_client/gen/spot/v1/spot_v1.pbgrpc.dart';
import 'package:dots_client/settings/settings.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grpc/grpc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

// Internal
import 'events.dart';
import 'state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final _logger = Logger("MainPageBloc");
  final AppSettings settings;

  MainPageBloc({required this.settings}) : super(InitingState()) {
    on<InitEvent>((event, emit) async {
      _logger.fine("Check geolocation permission");
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always &&
          permission != LocationPermission.whileInUse) {
        emit(LocationsPermissionIsNotAllowedState());
      }

      _logger.fine("Get current position");
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      emit(InitedState(position: position));

      _logger.fine("Subscribe on location");
      Geolocator.getPositionStream(
        desiredAccuracy: LocationAccuracy.high,
      ).listen((Position position) => emit(InitedState(position: position)));
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

        try {
          final response = await stub.createSpot(CreateSpotRequest());
          emit(NewSpotCreatedState(spotUuid: response.uuid));
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
        ),
      ),
    );

    add(InitEvent());
  }
}
