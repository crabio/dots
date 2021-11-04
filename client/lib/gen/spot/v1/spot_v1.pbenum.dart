///
//  Generated code. Do not modify.
//  source: spot/v1/spot_v1.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class StopSessionEvent_SessionWinner extends $pb.ProtobufEnum {
  static const StopSessionEvent_SessionWinner HunterWins = StopSessionEvent_SessionWinner._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'HunterWins');
  static const StopSessionEvent_SessionWinner VictimsWins = StopSessionEvent_SessionWinner._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VictimsWins');
  static const StopSessionEvent_SessionWinner Draw = StopSessionEvent_SessionWinner._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Draw');

  static const $core.List<StopSessionEvent_SessionWinner> values = <StopSessionEvent_SessionWinner> [
    HunterWins,
    VictimsWins,
    Draw,
  ];

  static final $core.Map<$core.int, StopSessionEvent_SessionWinner> _byValue = $pb.ProtobufEnum.initByValue(values);
  static StopSessionEvent_SessionWinner? valueOf($core.int value) => _byValue[value];

  const StopSessionEvent_SessionWinner._($core.int v, $core.String n) : super(v, n);
}

