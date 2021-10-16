// External
import 'package:dartz/dartz.dart';
import 'package:dots_client/settings/settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grpc/grpc.dart';
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';

// Internal
import 'package:dots_client/gen/spot/v1/spot_v1.pbgrpc.dart';
import 'events.dart';
import 'state.dart';

class SpotPageBloc extends Bloc<SpotPageEvent, SpotPageState> {
  final ClientChannel channel;
  final GeolocatorPlatform geolocator;
  final _logger = Logger("SpotPageBloc");

  SpotPageBloc({
    required this.channel,
    required this.geolocator,
    required String spotUuid,
  }) : super(InitingState()) {
    on<InitEvent>(_onInitEvent);
    on<NewGeoPositionEvent>(_onNewGeoPositionEvent);

    add(InitEvent(spotUuid: spotUuid));
  }

  void _onInitEvent(InitEvent event, Emitter<SpotPageState> emit) async {
    _logger.fine("Get spot data");
    final stub = SpotServiceClient(channel);
    final request = GetSpotRequest(spotUuid: event.spotUuid);
    try {
      final response = await stub.getSpot(request);

      emit(InitedState(
        spotPosition: LatLng(
          response.position.latitude,
          response.position.longitude,
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

    _logger.fine("Subscribe on location");
    geolocator
        .getPositionStream(
          desiredAccuracy: LocationAccuracy.high,
        )
        .listen((position) => add(NewGeoPositionEvent(
                position: LatLng(
              position.latitude,
              position.longitude,
            ))));
  }

  Future<Either<Exception, GetSpotResponse>> _getSpotData(
      String spotUuid) async {
    final stub = SpotServiceClient(channel);
    final request = GetSpotRequest(spotUuid: spotUuid);
    try {
      return Right(await stub.getSpot(request));
    } on Exception catch (ex) {
      return Left(ex);
    }
  }

  void _onNewGeoPositionEvent(
      NewGeoPositionEvent event, Emitter<SpotPageState> emit) async {}
}
