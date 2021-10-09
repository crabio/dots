// External
import 'package:uuid/uuid.dart';

abstract class MainPageState {}

// Initial page state
class InitedState implements MainPageState {}

// State when creating new spot on server
class CreatingNewSpotState implements MainPageState {}

// State when new spot created
class NewSpotCreatedState implements MainPageState {
  final Uuid spotUuid;

  NewSpotCreatedState({required this.spotUuid});
}
