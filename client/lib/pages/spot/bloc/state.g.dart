// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension IdleStateCopyWith on IdleState {
  IdleState copyWith({
    Exception? exception,
    List<String>? playersList,
  }) {
    return IdleState(
      exception: exception ?? this.exception,
      playersList: playersList ?? this.playersList,
    );
  }
}

extension ActiveStateCopyWith on ActiveState {
  ActiveState copyWith({
    Map<String, PlayerState>? otherPlayersStates,
    PlayerState? playerState,
    LatLng? spotPosition,
    int? zoneRadius,
  }) {
    return ActiveState(
      otherPlayersStates: otherPlayersStates ?? this.otherPlayersStates,
      playerState: playerState ?? this.playerState,
      spotPosition: spotPosition ?? this.spotPosition,
      zoneRadius: zoneRadius ?? this.zoneRadius,
    );
  }
}
