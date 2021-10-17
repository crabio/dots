// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension InitedStateCopyWith on InitedState {
  InitedState copyWith({
    List<PlayerPosition>? otherPlayersPositions,
    int? playerHealth,
    LatLng? playerPosition,
    Duration? scanPeriod,
    LatLng? spotPosition,
    Duration? zonePeriod,
    int? zoneRadius,
  }) {
    return InitedState(
      otherPlayersPositions:
          otherPlayersPositions ?? this.otherPlayersPositions,
      playerHealth: playerHealth ?? this.playerHealth,
      playerPosition: playerPosition ?? this.playerPosition,
      scanPeriod: scanPeriod ?? this.scanPeriod,
      spotPosition: spotPosition ?? this.spotPosition,
      zonePeriod: zonePeriod ?? this.zonePeriod,
      zoneRadius: zoneRadius ?? this.zoneRadius,
    );
  }
}
