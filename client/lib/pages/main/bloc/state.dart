abstract class MainPageState {}

// Initial page state
class InitedState implements MainPageState {}

// State when creating new spot on server
class CreatingNewSpotState implements MainPageState {}

// State when new spot created
class NewSpotCreatedState implements MainPageState {
  final String spotUuid;

  NewSpotCreatedState({required this.spotUuid});
}

// State when couldn't create spot
class CreateSpotErrorState implements MainPageState {
  final String error;

  CreateSpotErrorState({required this.error});
}
