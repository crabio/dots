// Internal
part of 'bloc.dart';

class LobbyPageEvent extends Equatable {
  const LobbyPageEvent();

  @override
  List<Object> get props => [];
}

/// Event for initing all required components
class InitEvent extends LobbyPageEvent {
  const InitEvent();
}

class NewSpotPlayersListEvent extends LobbyPageEvent {
  final List<String> playersList;

  const NewSpotPlayersListEvent({required this.playersList});

  @override
  List<Object> get props => [playersList];
}

class StartGameEvent extends LobbyPageEvent {
  const StartGameEvent();
}

class LeaveSpotEvent extends LobbyPageEvent {
  const LeaveSpotEvent();
}
