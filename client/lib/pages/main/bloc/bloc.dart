// External
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
      (event, emit) {
        emit(CreatingNewSpotState());
        // Send reques to host

        final channel = ClientChannel(
          'localhost',
          port: 50051,
          options: ChannelOptions(
            credentials: ChannelCredentials.insecure(),
            codecRegistry:
                CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
          ),
        );

        // TODO Send new spot created event
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
