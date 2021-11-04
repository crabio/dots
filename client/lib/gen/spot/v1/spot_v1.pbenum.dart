///
//  Generated code. Do not modify.
//  source: spot/v1/spot_v1.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class StopGameEvent_GameWinner extends $pb.ProtobufEnum {
  static const StopGameEvent_GameWinner HunterWins = StopGameEvent_GameWinner._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'HunterWins');
  static const StopGameEvent_GameWinner VictimsWins = StopGameEvent_GameWinner._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VictimsWins');
  static const StopGameEvent_GameWinner Draw = StopGameEvent_GameWinner._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Draw');

  static const $core.List<StopGameEvent_GameWinner> values = <StopGameEvent_GameWinner> [
    HunterWins,
    VictimsWins,
    Draw,
  ];

  static final $core.Map<$core.int, StopGameEvent_GameWinner> _byValue = $pb.ProtobufEnum.initByValue(values);
  static StopGameEvent_GameWinner? valueOf($core.int value) => _byValue[value];

  const StopGameEvent_GameWinner._($core.int v, $core.String n) : super(v, n);
}

