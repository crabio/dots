part of 'bloc.dart';

@immutable
abstract class GamePageEvent extends Equatable {
  const GamePageEvent();

  @override
  List<Object> get props => [];
}

/// Event for initing all required components
class InitEvent extends GamePageEvent {}

/// New players states event
class NewPlayersStatesEvent extends GamePageEvent {
  final String playerUuid;
  final LatLng playerPosition;
  final int playerHealth;

  const NewPlayersStatesEvent({
    required this.playerUuid,
    required this.playerHealth,
    required this.playerPosition,
  });

  @override
  List<Object> get props => [
        playerUuid,
        playerPosition,
        playerHealth,
      ];
}
