// External
import 'package:uuid/uuid.dart';

abstract class MainPageEvent {}

/// Create new spot event
class CreateNewSpotEvent extends MainPageEvent {}

/// New spot created event
class NewSpotCreatedEvent extends MainPageEvent {
  final Uuid spotUuid;

  NewSpotCreatedEvent({required this.spotUuid});
}
