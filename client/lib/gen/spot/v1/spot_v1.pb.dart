///
//  Generated code. Do not modify.
//  source: spot/v1/spot_v1.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class CreateSpotRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateSpotRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'longitude', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'latiitude', $pb.PbFieldType.OD)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'radius', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scanPeriodInSeconds', $pb.PbFieldType.O3, protoName: 'scanPeriodInSeconds')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'zonePeriodInSeconds', $pb.PbFieldType.O3, protoName: 'zonePeriodInSeconds')
    ..hasRequiredFields = false
  ;

  CreateSpotRequest._() : super();
  factory CreateSpotRequest({
    $core.double? longitude,
    $core.double? latiitude,
    $core.int? radius,
    $core.int? scanPeriodInSeconds,
    $core.int? zonePeriodInSeconds,
  }) {
    final _result = create();
    if (longitude != null) {
      _result.longitude = longitude;
    }
    if (latiitude != null) {
      _result.latiitude = latiitude;
    }
    if (radius != null) {
      _result.radius = radius;
    }
    if (scanPeriodInSeconds != null) {
      _result.scanPeriodInSeconds = scanPeriodInSeconds;
    }
    if (zonePeriodInSeconds != null) {
      _result.zonePeriodInSeconds = zonePeriodInSeconds;
    }
    return _result;
  }
  factory CreateSpotRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateSpotRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateSpotRequest clone() => CreateSpotRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateSpotRequest copyWith(void Function(CreateSpotRequest) updates) => super.copyWith((message) => updates(message as CreateSpotRequest)) as CreateSpotRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateSpotRequest create() => CreateSpotRequest._();
  CreateSpotRequest createEmptyInstance() => create();
  static $pb.PbList<CreateSpotRequest> createRepeated() => $pb.PbList<CreateSpotRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateSpotRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateSpotRequest>(create);
  static CreateSpotRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get longitude => $_getN(0);
  @$pb.TagNumber(1)
  set longitude($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLongitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLongitude() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get latiitude => $_getN(1);
  @$pb.TagNumber(2)
  set latiitude($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLatiitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLatiitude() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get radius => $_getIZ(2);
  @$pb.TagNumber(3)
  set radius($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRadius() => $_has(2);
  @$pb.TagNumber(3)
  void clearRadius() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get scanPeriodInSeconds => $_getIZ(3);
  @$pb.TagNumber(4)
  set scanPeriodInSeconds($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasScanPeriodInSeconds() => $_has(3);
  @$pb.TagNumber(4)
  void clearScanPeriodInSeconds() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get zonePeriodInSeconds => $_getIZ(4);
  @$pb.TagNumber(5)
  set zonePeriodInSeconds($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasZonePeriodInSeconds() => $_has(4);
  @$pb.TagNumber(5)
  void clearZonePeriodInSeconds() => clearField(5);
}

class CreateSpotResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateSpotResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuid')
    ..hasRequiredFields = false
  ;

  CreateSpotResponse._() : super();
  factory CreateSpotResponse({
    $core.String? uuid,
  }) {
    final _result = create();
    if (uuid != null) {
      _result.uuid = uuid;
    }
    return _result;
  }
  factory CreateSpotResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateSpotResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateSpotResponse clone() => CreateSpotResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateSpotResponse copyWith(void Function(CreateSpotResponse) updates) => super.copyWith((message) => updates(message as CreateSpotResponse)) as CreateSpotResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateSpotResponse create() => CreateSpotResponse._();
  CreateSpotResponse createEmptyInstance() => create();
  static $pb.PbList<CreateSpotResponse> createRepeated() => $pb.PbList<CreateSpotResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateSpotResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateSpotResponse>(create);
  static CreateSpotResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => clearField(1);
}

class GetSpotRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSpotRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuid')
    ..hasRequiredFields = false
  ;

  GetSpotRequest._() : super();
  factory GetSpotRequest({
    $core.String? uuid,
  }) {
    final _result = create();
    if (uuid != null) {
      _result.uuid = uuid;
    }
    return _result;
  }
  factory GetSpotRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSpotRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSpotRequest clone() => GetSpotRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSpotRequest copyWith(void Function(GetSpotRequest) updates) => super.copyWith((message) => updates(message as GetSpotRequest)) as GetSpotRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSpotRequest create() => GetSpotRequest._();
  GetSpotRequest createEmptyInstance() => create();
  static $pb.PbList<GetSpotRequest> createRepeated() => $pb.PbList<GetSpotRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSpotRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSpotRequest>(create);
  static GetSpotRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => clearField(1);
}

class GetSpotResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSpotResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'longitude', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'latiitude', $pb.PbFieldType.OD)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'radius', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scanPeriodInSeconds', $pb.PbFieldType.O3, protoName: 'scanPeriodInSeconds')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'zonePeriodInSeconds', $pb.PbFieldType.O3, protoName: 'zonePeriodInSeconds')
    ..hasRequiredFields = false
  ;

  GetSpotResponse._() : super();
  factory GetSpotResponse({
    $core.double? longitude,
    $core.double? latiitude,
    $core.int? radius,
    $core.int? scanPeriodInSeconds,
    $core.int? zonePeriodInSeconds,
  }) {
    final _result = create();
    if (longitude != null) {
      _result.longitude = longitude;
    }
    if (latiitude != null) {
      _result.latiitude = latiitude;
    }
    if (radius != null) {
      _result.radius = radius;
    }
    if (scanPeriodInSeconds != null) {
      _result.scanPeriodInSeconds = scanPeriodInSeconds;
    }
    if (zonePeriodInSeconds != null) {
      _result.zonePeriodInSeconds = zonePeriodInSeconds;
    }
    return _result;
  }
  factory GetSpotResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSpotResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSpotResponse clone() => GetSpotResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSpotResponse copyWith(void Function(GetSpotResponse) updates) => super.copyWith((message) => updates(message as GetSpotResponse)) as GetSpotResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSpotResponse create() => GetSpotResponse._();
  GetSpotResponse createEmptyInstance() => create();
  static $pb.PbList<GetSpotResponse> createRepeated() => $pb.PbList<GetSpotResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSpotResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSpotResponse>(create);
  static GetSpotResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get longitude => $_getN(0);
  @$pb.TagNumber(1)
  set longitude($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLongitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLongitude() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get latiitude => $_getN(1);
  @$pb.TagNumber(2)
  set latiitude($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLatiitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLatiitude() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get radius => $_getIZ(2);
  @$pb.TagNumber(3)
  set radius($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRadius() => $_has(2);
  @$pb.TagNumber(3)
  void clearRadius() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get scanPeriodInSeconds => $_getIZ(3);
  @$pb.TagNumber(4)
  set scanPeriodInSeconds($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasScanPeriodInSeconds() => $_has(3);
  @$pb.TagNumber(4)
  void clearScanPeriodInSeconds() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get zonePeriodInSeconds => $_getIZ(4);
  @$pb.TagNumber(5)
  set zonePeriodInSeconds($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasZonePeriodInSeconds() => $_has(4);
  @$pb.TagNumber(5)
  void clearZonePeriodInSeconds() => clearField(5);
}

