abstract class MainPageEvent {}

/// Event for initing all required components
class InitEvent extends MainPageEvent {}

/// Create new spot event
class CreateNewSpotEvent extends MainPageEvent {}

/// New spot created event
class NewSpotCreatedEvent extends MainPageEvent {
  final String spotUuid;

  NewSpotCreatedEvent({required this.spotUuid});
}
