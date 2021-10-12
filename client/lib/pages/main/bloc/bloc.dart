// External
import 'package:dots_client/gen/spot/v1/spot_v1.pbgrpc.dart';
import 'package:dots_client/settings/settings.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grpc/grpc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';

// Internal
import 'events.dart';
import 'state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final AppSettings settings;

  final _logger = Logger("MainPageBloc");

  MainPageBloc({
    required this.settings,
  }) : super(InitingState()) {
    on<InitEvent>((event, emit) async {
      _logger.fine("Check geolocation permission");
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always &&
          permission != LocationPermission.whileInUse) {
        emit(LocationsPermissionIsNotAllowedState());
      }

      _logger.fine("Get last known position");
      final position = await Geolocator.getLastKnownPosition();
      if (position != null) {
        emit(InitedState(
            position: LatLng(position.latitude, position.longitude)));
      } else {
        emit(CouldntGetPositionState());
        return;
      }

      _logger.fine("Subscribe on location");
      Geolocator.getPositionStream(
        desiredAccuracy: LocationAccuracy.high,
      ).listen((position) => add(NewGeoPositionEvent(
              position: LatLng(
            position.latitude,
            position.longitude,
          ))));
    });
    on<NewGeoPositionEvent>((event, emit) async {
      if (state is InitedState) {
        emit(InitedState(position: event.position));
      }
    });
    // on<CreateNewSpotEvent>(
    //   (event, emit) async {
    //     emit(CreatingNewSpotState());
    //     // Send reques to host

    //     final channel = ClientChannel(
    //       settings.environment.host,
    //       port: settings.environment.port,
    //       options: const ChannelOptions(
    //         credentials: ChannelCredentials.insecure(),
    //       ),
    //     );

    //     final stub = SpotServiceClient(channel);
    //     final request = CreateSpotRequest(
    //       longitude: event.position.longitude,
    //       latiitude: event.position.latitude,
    //     );
    //     try {
    //       final response = await stub.createSpot(request);

    //       add(NewSpotCreatedEvent(
    //         spotUuid: response.uuid,
    //         position: LatLng(
    //           response.latiitude,
    //           response.longitude,
    //         ),
    //       ));
    //     } catch (ex) {
    //       emit(CreateSpotErrorState(error: ex.toString()));
    //     }

    //     await channel.shutdown();
    //   },
    // );
    // on<NewSpotCreatedEvent>(
    //   (event, emit) => emit(
    //     NewSpotCreatedState(
    //       spotUuid: event.spotUuid,
    //       position: event.position,
    //     ),
    //   ),
    // );

    add(InitEvent());
  }
}
