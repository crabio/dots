///
//  Generated code. Do not modify.
//  source: spot_qr_code.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class SpotQrCode extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SpotQrCode', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot_qr_code'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'spotUuid')
    ..hasRequiredFields = false
  ;

  SpotQrCode._() : super();
  factory SpotQrCode({
    $core.String? spotUuid,
  }) {
    final _result = create();
    if (spotUuid != null) {
      _result.spotUuid = spotUuid;
    }
    return _result;
  }
  factory SpotQrCode.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SpotQrCode.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SpotQrCode clone() => SpotQrCode()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SpotQrCode copyWith(void Function(SpotQrCode) updates) => super.copyWith((message) => updates(message as SpotQrCode)) as SpotQrCode; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SpotQrCode create() => SpotQrCode._();
  SpotQrCode createEmptyInstance() => create();
  static $pb.PbList<SpotQrCode> createRepeated() => $pb.PbList<SpotQrCode>();
  @$core.pragma('dart2js:noInline')
  static SpotQrCode getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SpotQrCode>(create);
  static SpotQrCode? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get spotUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set spotUuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSpotUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearSpotUuid() => clearField(1);
}

