// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension InitedStateCopyWith on InitedState {
  InitedState copyWith({
    Map<String, PlayerState>? otherPlayersStates,
    PlayerState? playerState,
    Duration? scanPeriod,
    LatLng? spotPosition,
    Duration? zonePeriod,
    int? zoneRadius,
  }) {
    return InitedState(
      otherPlayersStates: otherPlayersStates ?? this.otherPlayersStates,
      playerState: playerState ?? this.playerState,
      scanPeriod: scanPeriod ?? this.scanPeriod,
      spotPosition: spotPosition ?? this.spotPosition,
      zonePeriod: zonePeriod ?? this.zonePeriod,
      zoneRadius: zoneRadius ?? this.zoneRadius,
    );
  }
}
