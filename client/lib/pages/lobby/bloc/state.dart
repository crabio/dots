// Internal
part of 'bloc.dart';

abstract class LobbyPageState extends Equatable {
  const LobbyPageState();

  @override
  List<Object?> get props => [];
}

// Initial page state
class InitingState extends LobbyPageState {}

// Inited state
class InitedState extends LobbyPageState {
  final List<String> playersList;

  const InitedState({required this.playersList});

  @override
  List<Object?> get props => [playersList];
}

class GoToGameState extends LobbyPageState {}

// State inited with error
class InitErrorState extends LobbyPageState {
  final Exception exception;

  const InitErrorState({required this.exception});

  @override
  List<Object> get props => [exception];
}
