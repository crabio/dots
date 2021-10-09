// External
import 'package:dots_client/gen/spot/v1/spot_v1.pbgrpc.dart';
import 'package:dots_client/settings/settings.dart';
import 'package:grpc/grpc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Internal
import 'events.dart';
import 'state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final AppSettings settings;

  MainPageBloc({required this.settings}) : super(InitedState()) {
    on<CreateNewSpotEvent>(
      (event, emit) async {
        emit(CreatingNewSpotState());
        // Send reques to host

        final channel = ClientChannel(
          settings.environment.host,
          port: settings.environment.port,
          options: ChannelOptions(
            credentials: const ChannelCredentials.insecure(),
            codecRegistry:
                CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
          ),
        );

        final stub = SpotServiceClient(channel);

        try {
          final response = await stub.createSpot(
            CreateSpotRequest(),
            options: CallOptions(
              compression: const GzipCodec(),
            ),
          );
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
  }
}
