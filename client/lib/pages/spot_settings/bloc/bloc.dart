// External
import 'package:dots_client/gen/spot/v1/spot_v1.pbgrpc.dart';
import 'package:dots_client/settings/settings.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grpc/grpc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';

// Internal
import 'events.dart';
import 'state.dart';

class SpotSettingsPageBloc
    extends Bloc<SpotSettingsPageEvent, SpotSettingsPageState> {
  final _logger = Logger("SpotSettingsPageBloc");

  SpotSettingsPageBloc({required position})
      : super(InitedState(position: position));
}
