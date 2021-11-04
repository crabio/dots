///
//  Generated code. Do not modify.
//  source: spot/v1/spot_v1.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use createSpotRequestDescriptor instead')
const CreateSpotRequest$json = const {
  '1': 'CreateSpotRequest',
  '2': const [
    const {
      '1': 'position',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.spot.v1.Position',
      '10': 'position'
    },
    const {'1': 'radius_in_m', '3': 2, '4': 1, '5': 2, '10': 'radiusInM'},
    const {
      '1': 'scan_period_in_seconds',
      '3': 3,
      '4': 1,
      '5': 5,
      '10': 'scanPeriodInSeconds'
    },
    const {
      '1': 'zone_period_in_seconds',
      '3': 4,
      '4': 1,
      '5': 5,
      '10': 'zonePeriodInSeconds'
    },
    const {
      '1': 'session_duration_in_seconds',
      '3': 5,
      '4': 1,
      '5': 5,
      '10': 'sessionDurationInSeconds'
    },
  ],
};

/// Descriptor for `CreateSpotRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSpotRequestDescriptor = $convert.base64Decode(
    'ChFDcmVhdGVTcG90UmVxdWVzdBItCghwb3NpdGlvbhgBIAEoCzIRLnNwb3QudjEuUG9zaXRpb25SCHBvc2l0aW9uEh4KC3JhZGl1c19pbl9tGAIgASgCUglyYWRpdXNJbk0SMwoWc2Nhbl9wZXJpb2RfaW5fc2Vjb25kcxgDIAEoBVITc2NhblBlcmlvZEluU2Vjb25kcxIzChZ6b25lX3BlcmlvZF9pbl9zZWNvbmRzGAQgASgFUhN6b25lUGVyaW9kSW5TZWNvbmRzEj0KG3Nlc3Npb25fZHVyYXRpb25faW5fc2Vjb25kcxgFIAEoBVIYc2Vzc2lvbkR1cmF0aW9uSW5TZWNvbmRz');
@$core.Deprecated('Use createSpotResponseDescriptor instead')
const CreateSpotResponse$json = const {
  '1': 'CreateSpotResponse',
  '2': const [
    const {'1': 'spot_uuid', '3': 1, '4': 1, '5': 9, '10': 'spotUuid'},
  ],
};

/// Descriptor for `CreateSpotResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSpotResponseDescriptor =
    $convert.base64Decode(
        'ChJDcmVhdGVTcG90UmVzcG9uc2USGwoJc3BvdF91dWlkGAEgASgJUghzcG90VXVpZA==');
@$core.Deprecated('Use getSpotRequestDescriptor instead')
const GetSpotRequest$json = const {
  '1': 'GetSpotRequest',
  '2': const [
    const {'1': 'spot_uuid', '3': 1, '4': 1, '5': 9, '10': 'spotUuid'},
  ],
};

/// Descriptor for `GetSpotRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSpotRequestDescriptor = $convert.base64Decode(
    'Cg5HZXRTcG90UmVxdWVzdBIbCglzcG90X3V1aWQYASABKAlSCHNwb3RVdWlk');
@$core.Deprecated('Use getSpotResponseDescriptor instead')
const GetSpotResponse$json = const {
  '1': 'GetSpotResponse',
  '2': const [
    const {
      '1': 'position',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.spot.v1.Position',
      '10': 'position'
    },
    const {'1': 'radius_in_m', '3': 2, '4': 1, '5': 2, '10': 'radiusInM'},
    const {
      '1': 'scan_period_in_seconds',
      '3': 3,
      '4': 1,
      '5': 5,
      '10': 'scanPeriodInSeconds'
    },
    const {
      '1': 'zone_period_in_seconds',
      '3': 4,
      '4': 1,
      '5': 5,
      '10': 'zonePeriodInSeconds'
    },
  ],
};

/// Descriptor for `GetSpotResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSpotResponseDescriptor = $convert.base64Decode(
    'Cg9HZXRTcG90UmVzcG9uc2USLQoIcG9zaXRpb24YASABKAsyES5zcG90LnYxLlBvc2l0aW9uUghwb3NpdGlvbhIeCgtyYWRpdXNfaW5fbRgCIAEoAlIJcmFkaXVzSW5NEjMKFnNjYW5fcGVyaW9kX2luX3NlY29uZHMYAyABKAVSE3NjYW5QZXJpb2RJblNlY29uZHMSMwoWem9uZV9wZXJpb2RfaW5fc2Vjb25kcxgEIAEoBVITem9uZVBlcmlvZEluU2Vjb25kcw==');
@$core.Deprecated('Use joinToSpotRequestDescriptor instead')
const JoinToSpotRequest$json = const {
  '1': 'JoinToSpotRequest',
  '2': const [
    const {'1': 'spot_uuid', '3': 1, '4': 1, '5': 9, '10': 'spotUuid'},
    const {'1': 'player_uuid', '3': 2, '4': 1, '5': 9, '10': 'playerUuid'},
  ],
};

/// Descriptor for `JoinToSpotRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinToSpotRequestDescriptor = $convert.base64Decode(
    'ChFKb2luVG9TcG90UmVxdWVzdBIbCglzcG90X3V1aWQYASABKAlSCHNwb3RVdWlkEh8KC3BsYXllcl91dWlkGAIgASgJUgpwbGF5ZXJVdWlk');
@$core.Deprecated('Use joinToSpotResponseDescriptor instead')
const JoinToSpotResponse$json = const {
  '1': 'JoinToSpotResponse',
};

/// Descriptor for `JoinToSpotResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinToSpotResponseDescriptor =
    $convert.base64Decode('ChJKb2luVG9TcG90UmVzcG9uc2U=');
@$core.Deprecated('Use getSpotPlayersRequestDescriptor instead')
const GetSpotPlayersRequest$json = const {
  '1': 'GetSpotPlayersRequest',
  '2': const [
    const {'1': 'spot_uuid', '3': 1, '4': 1, '5': 9, '10': 'spotUuid'},
  ],
};

/// Descriptor for `GetSpotPlayersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSpotPlayersRequestDescriptor = $convert.base64Decode(
    'ChVHZXRTcG90UGxheWVyc1JlcXVlc3QSGwoJc3BvdF91dWlkGAEgASgJUghzcG90VXVpZA==');
@$core.Deprecated('Use getSpotPlayersResponseDescriptor instead')
const GetSpotPlayersResponse$json = const {
  '1': 'GetSpotPlayersResponse',
  '2': const [
    const {'1': 'players_list', '3': 1, '4': 3, '5': 9, '10': 'playersList'},
  ],
};

/// Descriptor for `GetSpotPlayersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSpotPlayersResponseDescriptor =
    $convert.base64Decode(
        'ChZHZXRTcG90UGxheWVyc1Jlc3BvbnNlEiEKDHBsYXllcnNfbGlzdBgBIAMoCVILcGxheWVyc0xpc3Q=');
@$core.Deprecated('Use startSpotRequestDescriptor instead')
const StartSpotRequest$json = const {
  '1': 'StartSpotRequest',
  '2': const [
    const {'1': 'spot_uuid', '3': 1, '4': 1, '5': 9, '10': 'spotUuid'},
  ],
};

/// Descriptor for `StartSpotRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startSpotRequestDescriptor = $convert.base64Decode(
    'ChBTdGFydFNwb3RSZXF1ZXN0EhsKCXNwb3RfdXVpZBgBIAEoCVIIc3BvdFV1aWQ=');
@$core.Deprecated('Use startSpotResponseDescriptor instead')
const StartSpotResponse$json = const {
  '1': 'StartSpotResponse',
};

/// Descriptor for `StartSpotResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startSpotResponseDescriptor =
    $convert.base64Decode('ChFTdGFydFNwb3RSZXNwb25zZQ==');
@$core.Deprecated('Use isPlayerHunterRequestDescriptor instead')
const IsPlayerHunterRequest$json = const {
  '1': 'IsPlayerHunterRequest',
  '2': const [
    const {'1': 'spot_uuid', '3': 1, '4': 1, '5': 9, '10': 'spotUuid'},
    const {'1': 'player_uuid', '3': 2, '4': 1, '5': 9, '10': 'playerUuid'},
  ],
};

/// Descriptor for `IsPlayerHunterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List isPlayerHunterRequestDescriptor = $convert.base64Decode(
    'ChVJc1BsYXllckh1bnRlclJlcXVlc3QSGwoJc3BvdF91dWlkGAEgASgJUghzcG90VXVpZBIfCgtwbGF5ZXJfdXVpZBgCIAEoCVIKcGxheWVyVXVpZA==');
@$core.Deprecated('Use isPlayerHunterResponseDescriptor instead')
const IsPlayerHunterResponse$json = const {
  '1': 'IsPlayerHunterResponse',
  '2': const [
    const {'1': 'is_hunter', '3': 1, '4': 1, '5': 8, '10': 'isHunter'},
  ],
};

/// Descriptor for `IsPlayerHunterResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List isPlayerHunterResponseDescriptor =
    $convert.base64Decode(
        'ChZJc1BsYXllckh1bnRlclJlc3BvbnNlEhsKCWlzX2h1bnRlchgBIAEoCFIIaXNIdW50ZXI=');
@$core.Deprecated('Use subSessionEventRequestDescriptor instead')
const SubSessionEventRequest$json = const {
  '1': 'SubSessionEventRequest',
  '2': const [
    const {'1': 'spot_uuid', '3': 1, '4': 1, '5': 9, '10': 'spotUuid'},
  ],
};

/// Descriptor for `SubSessionEventRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subSessionEventRequestDescriptor =
    $convert.base64Decode(
        'ChZTdWJTZXNzaW9uRXZlbnRSZXF1ZXN0EhsKCXNwb3RfdXVpZBgBIAEoCVIIc3BvdFV1aWQ=');
@$core.Deprecated('Use subSessionEventResponseDescriptor instead')
const SubSessionEventResponse$json = const {
  '1': 'SubSessionEventResponse',
  '2': const [
    const {
      '1': 'start_session_event',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.spot.v1.StartGameEvent',
      '9': 0,
      '10': 'startSessionEvent'
    },
    const {
      '1': 'stop_session_event',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.spot.v1.StopSessionEvent',
      '9': 0,
      '10': 'stopSessionEvent'
    },
  ],
  '8': const [
    const {'1': 'event'},
  ],
};

/// Descriptor for `SubSessionEventResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subSessionEventResponseDescriptor =
    $convert.base64Decode(
        'ChdTdWJTZXNzaW9uRXZlbnRSZXNwb25zZRJMChNzdGFydF9zZXNzaW9uX2V2ZW50GAEgASgLMhouc3BvdC52MS5TdGFydFNlc3Npb25FdmVudEgAUhFzdGFydFNlc3Npb25FdmVudBJJChJzdG9wX3Nlc3Npb25fZXZlbnQYAiABKAsyGS5zcG90LnYxLlN0b3BTZXNzaW9uRXZlbnRIAFIQc3RvcFNlc3Npb25FdmVudEIHCgVldmVudA==');
@$core.Deprecated('Use startSessionEventDescriptor instead')
const StartGameEvent$json = const {
  '1': 'StartGameEvent',
};

/// Descriptor for `StartGameEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startSessionEventDescriptor =
    $convert.base64Decode('ChFTdGFydFNlc3Npb25FdmVudA==');
@$core.Deprecated('Use stopSessionEventDescriptor instead')
const StopSessionEvent$json = const {
  '1': 'StopSessionEvent',
  '2': const [
    const {
      '1': 'winner',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.spot.v1.StopSessionEvent.GameWinner',
      '10': 'winner'
    },
  ],
  '4': const [StopSessionEvent_SessionWinner$json],
};

@$core.Deprecated('Use stopSessionEventDescriptor instead')
const StopSessionEvent_SessionWinner$json = const {
  '1': 'GameWinner',
  '2': const [
    const {'1': 'HunterWins', '2': 0},
    const {'1': 'VictimsWins', '2': 1},
    const {'1': 'Draw', '2': 2},
  ],
};

/// Descriptor for `StopSessionEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stopSessionEventDescriptor = $convert.base64Decode(
    'ChBTdG9wU2Vzc2lvbkV2ZW50Ej8KBndpbm5lchgBIAEoDjInLnNwb3QudjEuU3RvcFNlc3Npb25FdmVudC5TZXNzaW9uV2lubmVyUgZ3aW5uZXIiOgoNU2Vzc2lvbldpbm5lchIOCgpIdW50ZXJXaW5zEAASDwoLVmljdGltc1dpbnMQARIICgREcmF3EAI=');
@$core.Deprecated('Use sendPlayerPositionRequestDescriptor instead')
const SendPlayerPositionRequest$json = const {
  '1': 'SendPlayerPositionRequest',
  '2': const [
    const {'1': 'spot_uuid', '3': 1, '4': 1, '5': 9, '10': 'spotUuid'},
    const {'1': 'player_uuid', '3': 2, '4': 1, '5': 9, '10': 'playerUuid'},
    const {
      '1': 'position',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.spot.v1.Position',
      '10': 'position'
    },
  ],
};

/// Descriptor for `SendPlayerPositionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendPlayerPositionRequestDescriptor =
    $convert.base64Decode(
        'ChlTZW5kUGxheWVyUG9zaXRpb25SZXF1ZXN0EhsKCXNwb3RfdXVpZBgBIAEoCVIIc3BvdFV1aWQSHwoLcGxheWVyX3V1aWQYAiABKAlSCnBsYXllclV1aWQSLQoIcG9zaXRpb24YAyABKAsyES5zcG90LnYxLlBvc2l0aW9uUghwb3NpdGlvbg==');
@$core.Deprecated('Use sendPlayerPositionResponseDescriptor instead')
const SendPlayerPositionResponse$json = const {
  '1': 'SendPlayerPositionResponse',
};

/// Descriptor for `SendPlayerPositionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendPlayerPositionResponseDescriptor =
    $convert.base64Decode('ChpTZW5kUGxheWVyUG9zaXRpb25SZXNwb25zZQ==');
@$core.Deprecated('Use getPlayersStatesRequestDescriptor instead')
const GetPlayersStatesRequest$json = const {
  '1': 'GetPlayersStatesRequest',
  '2': const [
    const {'1': 'spot_uuid', '3': 1, '4': 1, '5': 9, '10': 'spotUuid'},
    const {'1': 'player_uuid', '3': 2, '4': 1, '5': 9, '10': 'playerUuid'},
  ],
};

/// Descriptor for `GetPlayersStatesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlayersStatesRequestDescriptor =
    $convert.base64Decode(
        'ChdHZXRQbGF5ZXJzU3RhdGVzUmVxdWVzdBIbCglzcG90X3V1aWQYASABKAlSCHNwb3RVdWlkEh8KC3BsYXllcl91dWlkGAIgASgJUgpwbGF5ZXJVdWlk');
@$core.Deprecated('Use getPlayersStatesResponseDescriptor instead')
const GetPlayersStatesResponse$json = const {
  '1': 'GetPlayersStatesResponse',
  '2': const [
    const {
      '1': 'player_state',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.spot.v1.PlayerState',
      '10': 'playerState'
    },
  ],
};

/// Descriptor for `GetPlayersStatesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlayersStatesResponseDescriptor =
    $convert.base64Decode(
        'ChhHZXRQbGF5ZXJzU3RhdGVzUmVzcG9uc2USNwoMcGxheWVyX3N0YXRlGAEgASgLMhQuc3BvdC52MS5QbGF5ZXJTdGF0ZVILcGxheWVyU3RhdGU=');
@$core.Deprecated('Use subZoneEventRequestDescriptor instead')
const SubZoneEventRequest$json = const {
  '1': 'SubZoneEventRequest',
  '2': const [
    const {'1': 'spot_uuid', '3': 1, '4': 1, '5': 9, '10': 'spotUuid'},
  ],
};

/// Descriptor for `SubZoneEventRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subZoneEventRequestDescriptor =
    $convert.base64Decode(
        'ChNTdWJab25lRXZlbnRSZXF1ZXN0EhsKCXNwb3RfdXVpZBgBIAEoCVIIc3BvdFV1aWQ=');
@$core.Deprecated('Use subZoneEventResponseDescriptor instead')
const SubZoneEventResponse$json = const {
  '1': 'SubZoneEventResponse',
  '2': const [
    const {
      '1': 'start_next_zone_timer_event',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.spot.v1.StartNextZoneTimerEvent',
      '9': 0,
      '10': 'startNextZoneTimerEvent'
    },
    const {
      '1': 'start_zone_delay_timer_event',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.spot.v1.StartZoneDelayTimerEvent',
      '9': 0,
      '10': 'startZoneDelayTimerEvent'
    },
    const {
      '1': 'zone_tick_event',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.spot.v1.ZoneTickEvent',
      '9': 0,
      '10': 'zoneTickEvent'
    },
  ],
  '8': const [
    const {'1': 'event'},
  ],
};

/// Descriptor for `SubZoneEventResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subZoneEventResponseDescriptor = $convert.base64Decode(
    'ChRTdWJab25lRXZlbnRSZXNwb25zZRJgChtzdGFydF9uZXh0X3pvbmVfdGltZXJfZXZlbnQYASABKAsyIC5zcG90LnYxLlN0YXJ0TmV4dFpvbmVUaW1lckV2ZW50SABSF3N0YXJ0TmV4dFpvbmVUaW1lckV2ZW50EmMKHHN0YXJ0X3pvbmVfZGVsYXlfdGltZXJfZXZlbnQYAiABKAsyIS5zcG90LnYxLlN0YXJ0Wm9uZURlbGF5VGltZXJFdmVudEgAUhhzdGFydFpvbmVEZWxheVRpbWVyRXZlbnQSQAoPem9uZV90aWNrX2V2ZW50GAMgASgLMhYuc3BvdC52MS5ab25lVGlja0V2ZW50SABSDXpvbmVUaWNrRXZlbnRCBwoFZXZlbnQ=');
@$core.Deprecated('Use getLastZoneEventRequestDescriptor instead')
const GetLastZoneEventRequest$json = const {
  '1': 'GetLastZoneEventRequest',
  '2': const [
    const {'1': 'spot_uuid', '3': 1, '4': 1, '5': 9, '10': 'spotUuid'},
  ],
};

/// Descriptor for `GetLastZoneEventRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLastZoneEventRequestDescriptor =
    $convert.base64Decode(
        'ChdHZXRMYXN0Wm9uZUV2ZW50UmVxdWVzdBIbCglzcG90X3V1aWQYASABKAlSCHNwb3RVdWlk');
@$core.Deprecated('Use getLastZoneEventResponseDescriptor instead')
const GetLastZoneEventResponse$json = const {
  '1': 'GetLastZoneEventResponse',
  '2': const [
    const {
      '1': 'start_next_zone_timer_event',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.spot.v1.StartNextZoneTimerEvent',
      '9': 0,
      '10': 'startNextZoneTimerEvent'
    },
    const {
      '1': 'start_zone_delay_timer_event',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.spot.v1.StartZoneDelayTimerEvent',
      '9': 0,
      '10': 'startZoneDelayTimerEvent'
    },
    const {
      '1': 'zone_tick_event',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.spot.v1.ZoneTickEvent',
      '9': 0,
      '10': 'zoneTickEvent'
    },
  ],
  '8': const [
    const {'1': 'event'},
  ],
};

/// Descriptor for `GetLastZoneEventResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLastZoneEventResponseDescriptor =
    $convert.base64Decode(
        'ChhHZXRMYXN0Wm9uZUV2ZW50UmVzcG9uc2USYAobc3RhcnRfbmV4dF96b25lX3RpbWVyX2V2ZW50GAEgASgLMiAuc3BvdC52MS5TdGFydE5leHRab25lVGltZXJFdmVudEgAUhdzdGFydE5leHRab25lVGltZXJFdmVudBJjChxzdGFydF96b25lX2RlbGF5X3RpbWVyX2V2ZW50GAIgASgLMiEuc3BvdC52MS5TdGFydFpvbmVEZWxheVRpbWVyRXZlbnRIAFIYc3RhcnRab25lRGVsYXlUaW1lckV2ZW50EkAKD3pvbmVfdGlja19ldmVudBgDIAEoCzIWLnNwb3QudjEuWm9uZVRpY2tFdmVudEgAUg16b25lVGlja0V2ZW50QgcKBWV2ZW50');
@$core.Deprecated('Use startNextZoneTimerEventDescriptor instead')
const StartNextZoneTimerEvent$json = const {
  '1': 'StartNextZoneTimerEvent',
  '2': const [
    const {
      '1': 'current_zone',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.spot.v1.ZoneState',
      '10': 'currentZone'
    },
    const {
      '1': 'next_zone_timestamp',
      '3': 2,
      '4': 1,
      '5': 3,
      '10': 'nextZoneTimestamp'
    },
  ],
};

/// Descriptor for `StartNextZoneTimerEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startNextZoneTimerEventDescriptor =
    $convert.base64Decode(
        'ChdTdGFydE5leHRab25lVGltZXJFdmVudBI1CgxjdXJyZW50X3pvbmUYASABKAsyEi5zcG90LnYxLlpvbmVTdGF0ZVILY3VycmVudFpvbmUSLgoTbmV4dF96b25lX3RpbWVzdGFtcBgCIAEoA1IRbmV4dFpvbmVUaW1lc3RhbXA=');
@$core.Deprecated('Use startZoneDelayTimerEventDescriptor instead')
const StartZoneDelayTimerEvent$json = const {
  '1': 'StartZoneDelayTimerEvent',
  '2': const [
    const {
      '1': 'current_zone',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.spot.v1.ZoneState',
      '10': 'currentZone'
    },
    const {
      '1': 'next_zone',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.spot.v1.ZoneState',
      '10': 'nextZone'
    },
    const {
      '1': 'zone_tick_start_timestamp',
      '3': 3,
      '4': 1,
      '5': 3,
      '10': 'zoneTickStartTimestamp'
    },
  ],
};

/// Descriptor for `StartZoneDelayTimerEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startZoneDelayTimerEventDescriptor =
    $convert.base64Decode(
        'ChhTdGFydFpvbmVEZWxheVRpbWVyRXZlbnQSNQoMY3VycmVudF96b25lGAEgASgLMhIuc3BvdC52MS5ab25lU3RhdGVSC2N1cnJlbnRab25lEi8KCW5leHRfem9uZRgCIAEoCzISLnNwb3QudjEuWm9uZVN0YXRlUghuZXh0Wm9uZRI5Chl6b25lX3RpY2tfc3RhcnRfdGltZXN0YW1wGAMgASgDUhZ6b25lVGlja1N0YXJ0VGltZXN0YW1w');
@$core.Deprecated('Use zoneTickEventDescriptor instead')
const ZoneTickEvent$json = const {
  '1': 'ZoneTickEvent',
  '2': const [
    const {
      '1': 'current_zone',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.spot.v1.ZoneState',
      '10': 'currentZone'
    },
    const {
      '1': 'next_zone',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.spot.v1.ZoneState',
      '10': 'nextZone'
    },
  ],
};

/// Descriptor for `ZoneTickEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List zoneTickEventDescriptor = $convert.base64Decode(
    'Cg1ab25lVGlja0V2ZW50EjUKDGN1cnJlbnRfem9uZRgBIAEoCzISLnNwb3QudjEuWm9uZVN0YXRlUgtjdXJyZW50Wm9uZRIvCgluZXh0X3pvbmUYAiABKAsyEi5zcG90LnYxLlpvbmVTdGF0ZVIIbmV4dFpvbmU=');
@$core.Deprecated('Use playerStateDescriptor instead')
const PlayerState$json = const {
  '1': 'PlayerState',
  '2': const [
    const {'1': 'player_uuid', '3': 1, '4': 1, '5': 9, '10': 'playerUuid'},
    const {
      '1': 'position',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.spot.v1.Position',
      '10': 'position'
    },
    const {'1': 'health', '3': 3, '4': 1, '5': 2, '10': 'health'},
  ],
};

/// Descriptor for `PlayerState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerStateDescriptor = $convert.base64Decode(
    'CgtQbGF5ZXJTdGF0ZRIfCgtwbGF5ZXJfdXVpZBgBIAEoCVIKcGxheWVyVXVpZBItCghwb3NpdGlvbhgCIAEoCzIRLnNwb3QudjEuUG9zaXRpb25SCHBvc2l0aW9uEhYKBmhlYWx0aBgDIAEoAlIGaGVhbHRo');
@$core.Deprecated('Use zoneStateDescriptor instead')
const ZoneState$json = const {
  '1': 'ZoneState',
  '2': const [
    const {
      '1': 'position',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.spot.v1.Position',
      '10': 'position'
    },
    const {'1': 'radius_in_m', '3': 2, '4': 1, '5': 2, '10': 'radiusInM'},
    const {'1': 'damage', '3': 3, '4': 1, '5': 2, '10': 'damage'},
  ],
};

/// Descriptor for `ZoneState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List zoneStateDescriptor = $convert.base64Decode(
    'Cglab25lU3RhdGUSLQoIcG9zaXRpb24YASABKAsyES5zcG90LnYxLlBvc2l0aW9uUghwb3NpdGlvbhIeCgtyYWRpdXNfaW5fbRgCIAEoAlIJcmFkaXVzSW5NEhYKBmRhbWFnZRgDIAEoAlIGZGFtYWdl');
@$core.Deprecated('Use positionDescriptor instead')
const Position$json = const {
  '1': 'Position',
  '2': const [
    const {'1': 'longitude', '3': 1, '4': 1, '5': 1, '10': 'longitude'},
    const {'1': 'latitude', '3': 2, '4': 1, '5': 1, '10': 'latitude'},
  ],
};

/// Descriptor for `Position`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List positionDescriptor = $convert.base64Decode(
    'CghQb3NpdGlvbhIcCglsb25naXR1ZGUYASABKAFSCWxvbmdpdHVkZRIaCghsYXRpdHVkZRgCIAEoAVIIbGF0aXR1ZGU=');
