// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension InitedStateCopyWith on InitedState {
  InitedState copyWith({
    ZoneState? currentZone,
    ZoneState? nextZone,
    DateTime? nextZoneTime,
    Map<String, PlayerState>? otherPlayersStates,
    PlayerState? playerState,
    DateTime? zoneTickStartTimestamp,
  }) {
    return InitedState(
      currentZone: currentZone ?? this.currentZone,
      nextZone: nextZone ?? this.nextZone,
      nextZoneTime: nextZoneTime ?? this.nextZoneTime,
      otherPlayersStates: otherPlayersStates ?? this.otherPlayersStates,
      playerState: playerState ?? this.playerState,
      zoneTickStartTimestamp:
          zoneTickStartTimestamp ?? this.zoneTickStartTimestamp,
    );
  }
}
