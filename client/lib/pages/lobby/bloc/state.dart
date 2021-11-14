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

class GoToGameState extends LobbyPageState {
  final bool isHunter;

  const GoToGameState({required this.isHunter});

  @override
  List<Object?> get props => [isHunter];
}

/// State will be emitted when LeaveSpotEvent raised and is was succeded
class LeavingSpotState extends LobbyPageState {
  const LeavingSpotState();
}

// State inited with error
class ErrorState extends LobbyPageState {
  final Exception exception;

  const ErrorState({required this.exception});

  @override
  List<Object> get props => [exception];
}
