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

class SpotPageBloc extends Bloc<SpotPageEvent, SpotPageState> {
  final AppSettings appSettings;
  final _logger = Logger("SpotPageBloc");

  SpotPageBloc({
    required this.appSettings,
    required String spotUuid,
  }) : super(InitingState()) {
    on<InitEvent>((event, emit) async {
      _logger.fine("Get spot data");
      final channel = ClientChannel(
        appSettings.environment.host,
        port: appSettings.environment.port,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );

      final stub = SpotServiceClient(channel);
      final request = GetSpotRequest(
        uuid: event.spotUuid,
      );
      try {
        final response = await stub.getSpot(request);

        emit(InitedState(
          spotPosition: LatLng(
            response.latiitude,
            response.longitude,
          ),
          zoneRadius: response.radius,
          scanPeriod: Duration(seconds: response.scanPeriodInSeconds),
          zonePeriod: Duration(seconds: response.zonePeriodInSeconds),
        ));
      } on Exception catch (ex) {
        emit(InitErrorState(exception: ex));
      }

      // // Couldn't check permission because we checked it before
      // _logger.fine("Get last known position");
      // final position = await Geolocator.getLastKnownPosition();
      // if (position != null) {
      //   emit(InitedState(
      //     spotPosition: spotPosition,
      //     position: LatLng(position.latitude, position.longitude),
      //   ));
      // } else {
      //   throw Exception("Position is null");
      // }

      // _logger.fine("Subscribe on location");
      // Geolocator.getPositionStream(
      //   desiredAccuracy: LocationAccuracy.high,
      // ).listen((position) => add(NewGeoPositionEvent(
      //         position: LatLng(
      //       position.latitude,
      //       position.longitude,
      //     ))));
    });
    // on<NewGeoPositionEvent>((event, emit) async {
    //   if (state is InitedState) {
    //     emit(InitedState(
    //       spotPosition: spotPosition,
    //       position: event.position,
    //     ));
    //   }
    // });

    add(InitEvent(spotUuid: spotUuid));
  }
}
