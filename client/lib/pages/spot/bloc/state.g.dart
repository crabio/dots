// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension InitedStateCopyWith on InitedState {
  InitedState copyWith({
    LatLng? playerPosition,
    Duration? scanPeriod,
    LatLng? spotPosition,
    Duration? zonePeriod,
    int? zoneRadius,
  }) {
    return InitedState(
      playerPosition: playerPosition ?? this.playerPosition,
      scanPeriod: scanPeriod ?? this.scanPeriod,
      spotPosition: spotPosition ?? this.spotPosition,
      zonePeriod: zonePeriod ?? this.zonePeriod,
      zoneRadius: zoneRadius ?? this.zoneRadius,
    );
  }
}
