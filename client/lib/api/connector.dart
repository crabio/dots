import 'package:dots_client/settings/controller.dart';
import 'package:dots_client/gen/spot/v1/spot_v1.pbgrpc.dart' as proto;
import 'package:grpc/grpc.dart';

class SpotServiceConnector {
  final AppSettingsController appSettingsController;

  SpotServiceConnector({required this.appSettingsController});

  get connect => proto.SpotServiceClient(
        ClientChannel(
          appSettingsController.settings.environment.host,
          port: appSettingsController.settings.environment.port,
          options: const ChannelOptions(
            credentials: ChannelCredentials.insecure(),
          ),
        ),
      );
}
