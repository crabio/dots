// External
import 'package:flutter_bloc/flutter_bloc.dart';

// Internal
import 'events.dart';
import 'state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageBloc() : super(InitedState()) {
    on<CreateNewSpotEvent>(
      (event, emit) {
        emit(CreatingNewSpotState());
        // TODO send reques to host
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
