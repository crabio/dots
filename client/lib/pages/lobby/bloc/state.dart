part of 'bloc.dart';

abstract class LobbyPageState extends Equatable {
  const LobbyPageState();

  @override
  List<Object?> get props => [];
}

@CopyWith()
class LobbyPageInitial extends LobbyPageState {
  final bool gettingPlayersList;
  final List<String> playersList;
  final String qrCodeData;

  const LobbyPageInitial({
    required this.gettingPlayersList,
    required this.playersList,
    required this.qrCodeData,
  });

  @override
  List<Object?> get props => [
        gettingPlayersList,
        playersList,
        qrCodeData,
      ];
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
