///
//  Generated code. Do not modify.
//  source: spot/v1/spot_v1.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class CreateSpotRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateSpotRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOM<Position>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', subBuilder: Position.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'radiusInM', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scanPeriodInSeconds', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'zonePeriodInSeconds', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  CreateSpotRequest._() : super();
  factory CreateSpotRequest({
    Position? position,
    $core.int? radiusInM,
    $core.int? scanPeriodInSeconds,
    $core.int? zonePeriodInSeconds,
  }) {
    final _result = create();
    if (position != null) {
      _result.position = position;
    }
    if (radiusInM != null) {
      _result.radiusInM = radiusInM;
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
  Position get position => $_getN(0);
  @$pb.TagNumber(1)
  set position(Position v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPosition() => $_has(0);
  @$pb.TagNumber(1)
  void clearPosition() => clearField(1);
  @$pb.TagNumber(1)
  Position ensurePosition() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get radiusInM => $_getIZ(1);
  @$pb.TagNumber(2)
  set radiusInM($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRadiusInM() => $_has(1);
  @$pb.TagNumber(2)
  void clearRadiusInM() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get scanPeriodInSeconds => $_getIZ(2);
  @$pb.TagNumber(3)
  set scanPeriodInSeconds($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasScanPeriodInSeconds() => $_has(2);
  @$pb.TagNumber(3)
  void clearScanPeriodInSeconds() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get zonePeriodInSeconds => $_getIZ(3);
  @$pb.TagNumber(4)
  set zonePeriodInSeconds($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasZonePeriodInSeconds() => $_has(3);
  @$pb.TagNumber(4)
  void clearZonePeriodInSeconds() => clearField(4);
}

class CreateSpotResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateSpotResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'spotUuid')
    ..hasRequiredFields = false
  ;

  CreateSpotResponse._() : super();
  factory CreateSpotResponse({
    $core.String? spotUuid,
  }) {
    final _result = create();
    if (spotUuid != null) {
      _result.spotUuid = spotUuid;
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
  $core.String get spotUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set spotUuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSpotUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearSpotUuid() => clearField(1);
}

class GetSpotRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSpotRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'spotUuid')
    ..hasRequiredFields = false
  ;

  GetSpotRequest._() : super();
  factory GetSpotRequest({
    $core.String? spotUuid,
  }) {
    final _result = create();
    if (spotUuid != null) {
      _result.spotUuid = spotUuid;
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
  $core.String get spotUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set spotUuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSpotUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearSpotUuid() => clearField(1);
}

class GetSpotResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSpotResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOM<Position>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', subBuilder: Position.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'radiusInM', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scanPeriodInSeconds', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'zonePeriodInSeconds', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetSpotResponse._() : super();
  factory GetSpotResponse({
    Position? position,
    $core.int? radiusInM,
    $core.int? scanPeriodInSeconds,
    $core.int? zonePeriodInSeconds,
  }) {
    final _result = create();
    if (position != null) {
      _result.position = position;
    }
    if (radiusInM != null) {
      _result.radiusInM = radiusInM;
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
  Position get position => $_getN(0);
  @$pb.TagNumber(1)
  set position(Position v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPosition() => $_has(0);
  @$pb.TagNumber(1)
  void clearPosition() => clearField(1);
  @$pb.TagNumber(1)
  Position ensurePosition() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get radiusInM => $_getIZ(1);
  @$pb.TagNumber(2)
  set radiusInM($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRadiusInM() => $_has(1);
  @$pb.TagNumber(2)
  void clearRadiusInM() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get scanPeriodInSeconds => $_getIZ(2);
  @$pb.TagNumber(3)
  set scanPeriodInSeconds($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasScanPeriodInSeconds() => $_has(2);
  @$pb.TagNumber(3)
  void clearScanPeriodInSeconds() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get zonePeriodInSeconds => $_getIZ(3);
  @$pb.TagNumber(4)
  set zonePeriodInSeconds($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasZonePeriodInSeconds() => $_has(3);
  @$pb.TagNumber(4)
  void clearZonePeriodInSeconds() => clearField(4);
}

class JoinToSpotRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'JoinToSpotRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'spotUuid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'playerUuid')
    ..hasRequiredFields = false
  ;

  JoinToSpotRequest._() : super();
  factory JoinToSpotRequest({
    $core.String? spotUuid,
    $core.String? playerUuid,
  }) {
    final _result = create();
    if (spotUuid != null) {
      _result.spotUuid = spotUuid;
    }
    if (playerUuid != null) {
      _result.playerUuid = playerUuid;
    }
    return _result;
  }
  factory JoinToSpotRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JoinToSpotRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JoinToSpotRequest clone() => JoinToSpotRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JoinToSpotRequest copyWith(void Function(JoinToSpotRequest) updates) => super.copyWith((message) => updates(message as JoinToSpotRequest)) as JoinToSpotRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static JoinToSpotRequest create() => JoinToSpotRequest._();
  JoinToSpotRequest createEmptyInstance() => create();
  static $pb.PbList<JoinToSpotRequest> createRepeated() => $pb.PbList<JoinToSpotRequest>();
  @$core.pragma('dart2js:noInline')
  static JoinToSpotRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JoinToSpotRequest>(create);
  static JoinToSpotRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get spotUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set spotUuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSpotUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearSpotUuid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get playerUuid => $_getSZ(1);
  @$pb.TagNumber(2)
  set playerUuid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPlayerUuid() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlayerUuid() => clearField(2);
}

class JoinToSpotResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'JoinToSpotResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  JoinToSpotResponse._() : super();
  factory JoinToSpotResponse() => create();
  factory JoinToSpotResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JoinToSpotResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JoinToSpotResponse clone() => JoinToSpotResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JoinToSpotResponse copyWith(void Function(JoinToSpotResponse) updates) => super.copyWith((message) => updates(message as JoinToSpotResponse)) as JoinToSpotResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static JoinToSpotResponse create() => JoinToSpotResponse._();
  JoinToSpotResponse createEmptyInstance() => create();
  static $pb.PbList<JoinToSpotResponse> createRepeated() => $pb.PbList<JoinToSpotResponse>();
  @$core.pragma('dart2js:noInline')
  static JoinToSpotResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JoinToSpotResponse>(create);
  static JoinToSpotResponse? _defaultInstance;
}

class GetSpotPlayersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSpotPlayersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'spotUuid')
    ..hasRequiredFields = false
  ;

  GetSpotPlayersRequest._() : super();
  factory GetSpotPlayersRequest({
    $core.String? spotUuid,
  }) {
    final _result = create();
    if (spotUuid != null) {
      _result.spotUuid = spotUuid;
    }
    return _result;
  }
  factory GetSpotPlayersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSpotPlayersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSpotPlayersRequest clone() => GetSpotPlayersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSpotPlayersRequest copyWith(void Function(GetSpotPlayersRequest) updates) => super.copyWith((message) => updates(message as GetSpotPlayersRequest)) as GetSpotPlayersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSpotPlayersRequest create() => GetSpotPlayersRequest._();
  GetSpotPlayersRequest createEmptyInstance() => create();
  static $pb.PbList<GetSpotPlayersRequest> createRepeated() => $pb.PbList<GetSpotPlayersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSpotPlayersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSpotPlayersRequest>(create);
  static GetSpotPlayersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get spotUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set spotUuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSpotUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearSpotUuid() => clearField(1);
}

class GetSpotPlayersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSpotPlayersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'playersList')
    ..hasRequiredFields = false
  ;

  GetSpotPlayersResponse._() : super();
  factory GetSpotPlayersResponse({
    $core.Iterable<$core.String>? playersList,
  }) {
    final _result = create();
    if (playersList != null) {
      _result.playersList.addAll(playersList);
    }
    return _result;
  }
  factory GetSpotPlayersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSpotPlayersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSpotPlayersResponse clone() => GetSpotPlayersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSpotPlayersResponse copyWith(void Function(GetSpotPlayersResponse) updates) => super.copyWith((message) => updates(message as GetSpotPlayersResponse)) as GetSpotPlayersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSpotPlayersResponse create() => GetSpotPlayersResponse._();
  GetSpotPlayersResponse createEmptyInstance() => create();
  static $pb.PbList<GetSpotPlayersResponse> createRepeated() => $pb.PbList<GetSpotPlayersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSpotPlayersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSpotPlayersResponse>(create);
  static GetSpotPlayersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get playersList => $_getList(0);
}

class StartSpotRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StartSpotRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'spotUuid')
    ..hasRequiredFields = false
  ;

  StartSpotRequest._() : super();
  factory StartSpotRequest({
    $core.String? spotUuid,
  }) {
    final _result = create();
    if (spotUuid != null) {
      _result.spotUuid = spotUuid;
    }
    return _result;
  }
  factory StartSpotRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StartSpotRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StartSpotRequest clone() => StartSpotRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StartSpotRequest copyWith(void Function(StartSpotRequest) updates) => super.copyWith((message) => updates(message as StartSpotRequest)) as StartSpotRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StartSpotRequest create() => StartSpotRequest._();
  StartSpotRequest createEmptyInstance() => create();
  static $pb.PbList<StartSpotRequest> createRepeated() => $pb.PbList<StartSpotRequest>();
  @$core.pragma('dart2js:noInline')
  static StartSpotRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StartSpotRequest>(create);
  static StartSpotRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get spotUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set spotUuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSpotUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearSpotUuid() => clearField(1);
}

class StartSpotResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StartSpotResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  StartSpotResponse._() : super();
  factory StartSpotResponse() => create();
  factory StartSpotResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StartSpotResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StartSpotResponse clone() => StartSpotResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StartSpotResponse copyWith(void Function(StartSpotResponse) updates) => super.copyWith((message) => updates(message as StartSpotResponse)) as StartSpotResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StartSpotResponse create() => StartSpotResponse._();
  StartSpotResponse createEmptyInstance() => create();
  static $pb.PbList<StartSpotResponse> createRepeated() => $pb.PbList<StartSpotResponse>();
  @$core.pragma('dart2js:noInline')
  static StartSpotResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StartSpotResponse>(create);
  static StartSpotResponse? _defaultInstance;
}

class IsPlayerHunterRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'IsPlayerHunterRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'spotUuid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'playerUuid')
    ..hasRequiredFields = false
  ;

  IsPlayerHunterRequest._() : super();
  factory IsPlayerHunterRequest({
    $core.String? spotUuid,
    $core.String? playerUuid,
  }) {
    final _result = create();
    if (spotUuid != null) {
      _result.spotUuid = spotUuid;
    }
    if (playerUuid != null) {
      _result.playerUuid = playerUuid;
    }
    return _result;
  }
  factory IsPlayerHunterRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IsPlayerHunterRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IsPlayerHunterRequest clone() => IsPlayerHunterRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IsPlayerHunterRequest copyWith(void Function(IsPlayerHunterRequest) updates) => super.copyWith((message) => updates(message as IsPlayerHunterRequest)) as IsPlayerHunterRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static IsPlayerHunterRequest create() => IsPlayerHunterRequest._();
  IsPlayerHunterRequest createEmptyInstance() => create();
  static $pb.PbList<IsPlayerHunterRequest> createRepeated() => $pb.PbList<IsPlayerHunterRequest>();
  @$core.pragma('dart2js:noInline')
  static IsPlayerHunterRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IsPlayerHunterRequest>(create);
  static IsPlayerHunterRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get spotUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set spotUuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSpotUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearSpotUuid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get playerUuid => $_getSZ(1);
  @$pb.TagNumber(2)
  set playerUuid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPlayerUuid() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlayerUuid() => clearField(2);
}

class IsPlayerHunterResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'IsPlayerHunterResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isHunter')
    ..hasRequiredFields = false
  ;

  IsPlayerHunterResponse._() : super();
  factory IsPlayerHunterResponse({
    $core.bool? isHunter,
  }) {
    final _result = create();
    if (isHunter != null) {
      _result.isHunter = isHunter;
    }
    return _result;
  }
  factory IsPlayerHunterResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IsPlayerHunterResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IsPlayerHunterResponse clone() => IsPlayerHunterResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IsPlayerHunterResponse copyWith(void Function(IsPlayerHunterResponse) updates) => super.copyWith((message) => updates(message as IsPlayerHunterResponse)) as IsPlayerHunterResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static IsPlayerHunterResponse create() => IsPlayerHunterResponse._();
  IsPlayerHunterResponse createEmptyInstance() => create();
  static $pb.PbList<IsPlayerHunterResponse> createRepeated() => $pb.PbList<IsPlayerHunterResponse>();
  @$core.pragma('dart2js:noInline')
  static IsPlayerHunterResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IsPlayerHunterResponse>(create);
  static IsPlayerHunterResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isHunter => $_getBF(0);
  @$pb.TagNumber(1)
  set isHunter($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsHunter() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsHunter() => clearField(1);
}

class GetSpotStartFlagRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSpotStartFlagRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'spotUuid')
    ..hasRequiredFields = false
  ;

  GetSpotStartFlagRequest._() : super();
  factory GetSpotStartFlagRequest({
    $core.String? spotUuid,
  }) {
    final _result = create();
    if (spotUuid != null) {
      _result.spotUuid = spotUuid;
    }
    return _result;
  }
  factory GetSpotStartFlagRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSpotStartFlagRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSpotStartFlagRequest clone() => GetSpotStartFlagRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSpotStartFlagRequest copyWith(void Function(GetSpotStartFlagRequest) updates) => super.copyWith((message) => updates(message as GetSpotStartFlagRequest)) as GetSpotStartFlagRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSpotStartFlagRequest create() => GetSpotStartFlagRequest._();
  GetSpotStartFlagRequest createEmptyInstance() => create();
  static $pb.PbList<GetSpotStartFlagRequest> createRepeated() => $pb.PbList<GetSpotStartFlagRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSpotStartFlagRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSpotStartFlagRequest>(create);
  static GetSpotStartFlagRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get spotUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set spotUuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSpotUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearSpotUuid() => clearField(1);
}

class GetSpotStartFlagResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSpotStartFlagResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..hasRequiredFields = false
  ;

  GetSpotStartFlagResponse._() : super();
  factory GetSpotStartFlagResponse({
    $core.bool? isActive,
  }) {
    final _result = create();
    if (isActive != null) {
      _result.isActive = isActive;
    }
    return _result;
  }
  factory GetSpotStartFlagResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSpotStartFlagResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSpotStartFlagResponse clone() => GetSpotStartFlagResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSpotStartFlagResponse copyWith(void Function(GetSpotStartFlagResponse) updates) => super.copyWith((message) => updates(message as GetSpotStartFlagResponse)) as GetSpotStartFlagResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSpotStartFlagResponse create() => GetSpotStartFlagResponse._();
  GetSpotStartFlagResponse createEmptyInstance() => create();
  static $pb.PbList<GetSpotStartFlagResponse> createRepeated() => $pb.PbList<GetSpotStartFlagResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSpotStartFlagResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSpotStartFlagResponse>(create);
  static GetSpotStartFlagResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isActive => $_getBF(0);
  @$pb.TagNumber(1)
  set isActive($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsActive() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsActive() => clearField(1);
}

class SendPlayerPositionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendPlayerPositionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'spotUuid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'playerUuid')
    ..aOM<Position>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', subBuilder: Position.create)
    ..hasRequiredFields = false
  ;

  SendPlayerPositionRequest._() : super();
  factory SendPlayerPositionRequest({
    $core.String? spotUuid,
    $core.String? playerUuid,
    Position? position,
  }) {
    final _result = create();
    if (spotUuid != null) {
      _result.spotUuid = spotUuid;
    }
    if (playerUuid != null) {
      _result.playerUuid = playerUuid;
    }
    if (position != null) {
      _result.position = position;
    }
    return _result;
  }
  factory SendPlayerPositionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendPlayerPositionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendPlayerPositionRequest clone() => SendPlayerPositionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendPlayerPositionRequest copyWith(void Function(SendPlayerPositionRequest) updates) => super.copyWith((message) => updates(message as SendPlayerPositionRequest)) as SendPlayerPositionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendPlayerPositionRequest create() => SendPlayerPositionRequest._();
  SendPlayerPositionRequest createEmptyInstance() => create();
  static $pb.PbList<SendPlayerPositionRequest> createRepeated() => $pb.PbList<SendPlayerPositionRequest>();
  @$core.pragma('dart2js:noInline')
  static SendPlayerPositionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendPlayerPositionRequest>(create);
  static SendPlayerPositionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get spotUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set spotUuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSpotUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearSpotUuid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get playerUuid => $_getSZ(1);
  @$pb.TagNumber(2)
  set playerUuid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPlayerUuid() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlayerUuid() => clearField(2);

  @$pb.TagNumber(3)
  Position get position => $_getN(2);
  @$pb.TagNumber(3)
  set position(Position v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPosition() => $_has(2);
  @$pb.TagNumber(3)
  void clearPosition() => clearField(3);
  @$pb.TagNumber(3)
  Position ensurePosition() => $_ensure(2);
}

class SendPlayerPositionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendPlayerPositionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SendPlayerPositionResponse._() : super();
  factory SendPlayerPositionResponse() => create();
  factory SendPlayerPositionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendPlayerPositionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendPlayerPositionResponse clone() => SendPlayerPositionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendPlayerPositionResponse copyWith(void Function(SendPlayerPositionResponse) updates) => super.copyWith((message) => updates(message as SendPlayerPositionResponse)) as SendPlayerPositionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendPlayerPositionResponse create() => SendPlayerPositionResponse._();
  SendPlayerPositionResponse createEmptyInstance() => create();
  static $pb.PbList<SendPlayerPositionResponse> createRepeated() => $pb.PbList<SendPlayerPositionResponse>();
  @$core.pragma('dart2js:noInline')
  static SendPlayerPositionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendPlayerPositionResponse>(create);
  static SendPlayerPositionResponse? _defaultInstance;
}

class GetPlayersStatesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPlayersStatesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'spotUuid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'playerUuid')
    ..hasRequiredFields = false
  ;

  GetPlayersStatesRequest._() : super();
  factory GetPlayersStatesRequest({
    $core.String? spotUuid,
    $core.String? playerUuid,
  }) {
    final _result = create();
    if (spotUuid != null) {
      _result.spotUuid = spotUuid;
    }
    if (playerUuid != null) {
      _result.playerUuid = playerUuid;
    }
    return _result;
  }
  factory GetPlayersStatesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPlayersStatesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPlayersStatesRequest clone() => GetPlayersStatesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPlayersStatesRequest copyWith(void Function(GetPlayersStatesRequest) updates) => super.copyWith((message) => updates(message as GetPlayersStatesRequest)) as GetPlayersStatesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPlayersStatesRequest create() => GetPlayersStatesRequest._();
  GetPlayersStatesRequest createEmptyInstance() => create();
  static $pb.PbList<GetPlayersStatesRequest> createRepeated() => $pb.PbList<GetPlayersStatesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPlayersStatesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPlayersStatesRequest>(create);
  static GetPlayersStatesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get spotUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set spotUuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSpotUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearSpotUuid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get playerUuid => $_getSZ(1);
  @$pb.TagNumber(2)
  set playerUuid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPlayerUuid() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlayerUuid() => clearField(2);
}

class GetPlayersStatesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPlayersStatesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOM<PlayerState>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'playerState', subBuilder: PlayerState.create)
    ..hasRequiredFields = false
  ;

  GetPlayersStatesResponse._() : super();
  factory GetPlayersStatesResponse({
    PlayerState? playerState,
  }) {
    final _result = create();
    if (playerState != null) {
      _result.playerState = playerState;
    }
    return _result;
  }
  factory GetPlayersStatesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPlayersStatesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPlayersStatesResponse clone() => GetPlayersStatesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPlayersStatesResponse copyWith(void Function(GetPlayersStatesResponse) updates) => super.copyWith((message) => updates(message as GetPlayersStatesResponse)) as GetPlayersStatesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPlayersStatesResponse create() => GetPlayersStatesResponse._();
  GetPlayersStatesResponse createEmptyInstance() => create();
  static $pb.PbList<GetPlayersStatesResponse> createRepeated() => $pb.PbList<GetPlayersStatesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPlayersStatesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPlayersStatesResponse>(create);
  static GetPlayersStatesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PlayerState get playerState => $_getN(0);
  @$pb.TagNumber(1)
  set playerState(PlayerState v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlayerState() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayerState() => clearField(1);
  @$pb.TagNumber(1)
  PlayerState ensurePlayerState() => $_ensure(0);
}

class SubZoneEventRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubZoneEventRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'spotUuid')
    ..hasRequiredFields = false
  ;

  SubZoneEventRequest._() : super();
  factory SubZoneEventRequest({
    $core.String? spotUuid,
  }) {
    final _result = create();
    if (spotUuid != null) {
      _result.spotUuid = spotUuid;
    }
    return _result;
  }
  factory SubZoneEventRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubZoneEventRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubZoneEventRequest clone() => SubZoneEventRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubZoneEventRequest copyWith(void Function(SubZoneEventRequest) updates) => super.copyWith((message) => updates(message as SubZoneEventRequest)) as SubZoneEventRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubZoneEventRequest create() => SubZoneEventRequest._();
  SubZoneEventRequest createEmptyInstance() => create();
  static $pb.PbList<SubZoneEventRequest> createRepeated() => $pb.PbList<SubZoneEventRequest>();
  @$core.pragma('dart2js:noInline')
  static SubZoneEventRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubZoneEventRequest>(create);
  static SubZoneEventRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get spotUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set spotUuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSpotUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearSpotUuid() => clearField(1);
}

enum SubZoneEventResponse_Event {
  startNextZoneTimerEvent, 
  startZoneDelayTimerEvent, 
  zoneTickEvent, 
  notSet
}

class SubZoneEventResponse extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, SubZoneEventResponse_Event> _SubZoneEventResponse_EventByTag = {
    1 : SubZoneEventResponse_Event.startNextZoneTimerEvent,
    2 : SubZoneEventResponse_Event.startZoneDelayTimerEvent,
    3 : SubZoneEventResponse_Event.zoneTickEvent,
    0 : SubZoneEventResponse_Event.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubZoneEventResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<StartNextZoneTimerEvent>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startNextZoneTimerEvent', subBuilder: StartNextZoneTimerEvent.create)
    ..aOM<StartZoneDelayTimerEvent>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startZoneDelayTimerEvent', subBuilder: StartZoneDelayTimerEvent.create)
    ..aOM<ZoneTickEvent>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'zoneTickEvent', subBuilder: ZoneTickEvent.create)
    ..hasRequiredFields = false
  ;

  SubZoneEventResponse._() : super();
  factory SubZoneEventResponse({
    StartNextZoneTimerEvent? startNextZoneTimerEvent,
    StartZoneDelayTimerEvent? startZoneDelayTimerEvent,
    ZoneTickEvent? zoneTickEvent,
  }) {
    final _result = create();
    if (startNextZoneTimerEvent != null) {
      _result.startNextZoneTimerEvent = startNextZoneTimerEvent;
    }
    if (startZoneDelayTimerEvent != null) {
      _result.startZoneDelayTimerEvent = startZoneDelayTimerEvent;
    }
    if (zoneTickEvent != null) {
      _result.zoneTickEvent = zoneTickEvent;
    }
    return _result;
  }
  factory SubZoneEventResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubZoneEventResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubZoneEventResponse clone() => SubZoneEventResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubZoneEventResponse copyWith(void Function(SubZoneEventResponse) updates) => super.copyWith((message) => updates(message as SubZoneEventResponse)) as SubZoneEventResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubZoneEventResponse create() => SubZoneEventResponse._();
  SubZoneEventResponse createEmptyInstance() => create();
  static $pb.PbList<SubZoneEventResponse> createRepeated() => $pb.PbList<SubZoneEventResponse>();
  @$core.pragma('dart2js:noInline')
  static SubZoneEventResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubZoneEventResponse>(create);
  static SubZoneEventResponse? _defaultInstance;

  SubZoneEventResponse_Event whichEvent() => _SubZoneEventResponse_EventByTag[$_whichOneof(0)]!;
  void clearEvent() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  StartNextZoneTimerEvent get startNextZoneTimerEvent => $_getN(0);
  @$pb.TagNumber(1)
  set startNextZoneTimerEvent(StartNextZoneTimerEvent v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartNextZoneTimerEvent() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartNextZoneTimerEvent() => clearField(1);
  @$pb.TagNumber(1)
  StartNextZoneTimerEvent ensureStartNextZoneTimerEvent() => $_ensure(0);

  @$pb.TagNumber(2)
  StartZoneDelayTimerEvent get startZoneDelayTimerEvent => $_getN(1);
  @$pb.TagNumber(2)
  set startZoneDelayTimerEvent(StartZoneDelayTimerEvent v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStartZoneDelayTimerEvent() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartZoneDelayTimerEvent() => clearField(2);
  @$pb.TagNumber(2)
  StartZoneDelayTimerEvent ensureStartZoneDelayTimerEvent() => $_ensure(1);

  @$pb.TagNumber(3)
  ZoneTickEvent get zoneTickEvent => $_getN(2);
  @$pb.TagNumber(3)
  set zoneTickEvent(ZoneTickEvent v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasZoneTickEvent() => $_has(2);
  @$pb.TagNumber(3)
  void clearZoneTickEvent() => clearField(3);
  @$pb.TagNumber(3)
  ZoneTickEvent ensureZoneTickEvent() => $_ensure(2);
}

class StartNextZoneTimerEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StartNextZoneTimerEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOM<ZoneState>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentZone', subBuilder: ZoneState.create)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextZoneTimestamp')
    ..hasRequiredFields = false
  ;

  StartNextZoneTimerEvent._() : super();
  factory StartNextZoneTimerEvent({
    ZoneState? currentZone,
    $fixnum.Int64? nextZoneTimestamp,
  }) {
    final _result = create();
    if (currentZone != null) {
      _result.currentZone = currentZone;
    }
    if (nextZoneTimestamp != null) {
      _result.nextZoneTimestamp = nextZoneTimestamp;
    }
    return _result;
  }
  factory StartNextZoneTimerEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StartNextZoneTimerEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StartNextZoneTimerEvent clone() => StartNextZoneTimerEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StartNextZoneTimerEvent copyWith(void Function(StartNextZoneTimerEvent) updates) => super.copyWith((message) => updates(message as StartNextZoneTimerEvent)) as StartNextZoneTimerEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StartNextZoneTimerEvent create() => StartNextZoneTimerEvent._();
  StartNextZoneTimerEvent createEmptyInstance() => create();
  static $pb.PbList<StartNextZoneTimerEvent> createRepeated() => $pb.PbList<StartNextZoneTimerEvent>();
  @$core.pragma('dart2js:noInline')
  static StartNextZoneTimerEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StartNextZoneTimerEvent>(create);
  static StartNextZoneTimerEvent? _defaultInstance;

  @$pb.TagNumber(1)
  ZoneState get currentZone => $_getN(0);
  @$pb.TagNumber(1)
  set currentZone(ZoneState v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrentZone() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentZone() => clearField(1);
  @$pb.TagNumber(1)
  ZoneState ensureCurrentZone() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get nextZoneTimestamp => $_getI64(1);
  @$pb.TagNumber(2)
  set nextZoneTimestamp($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextZoneTimestamp() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextZoneTimestamp() => clearField(2);
}

class StartZoneDelayTimerEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StartZoneDelayTimerEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOM<ZoneState>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentZone', subBuilder: ZoneState.create)
    ..aOM<ZoneState>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextZone', subBuilder: ZoneState.create)
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'zoneTickStartTimestamp')
    ..hasRequiredFields = false
  ;

  StartZoneDelayTimerEvent._() : super();
  factory StartZoneDelayTimerEvent({
    ZoneState? currentZone,
    ZoneState? nextZone,
    $fixnum.Int64? zoneTickStartTimestamp,
  }) {
    final _result = create();
    if (currentZone != null) {
      _result.currentZone = currentZone;
    }
    if (nextZone != null) {
      _result.nextZone = nextZone;
    }
    if (zoneTickStartTimestamp != null) {
      _result.zoneTickStartTimestamp = zoneTickStartTimestamp;
    }
    return _result;
  }
  factory StartZoneDelayTimerEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StartZoneDelayTimerEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StartZoneDelayTimerEvent clone() => StartZoneDelayTimerEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StartZoneDelayTimerEvent copyWith(void Function(StartZoneDelayTimerEvent) updates) => super.copyWith((message) => updates(message as StartZoneDelayTimerEvent)) as StartZoneDelayTimerEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StartZoneDelayTimerEvent create() => StartZoneDelayTimerEvent._();
  StartZoneDelayTimerEvent createEmptyInstance() => create();
  static $pb.PbList<StartZoneDelayTimerEvent> createRepeated() => $pb.PbList<StartZoneDelayTimerEvent>();
  @$core.pragma('dart2js:noInline')
  static StartZoneDelayTimerEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StartZoneDelayTimerEvent>(create);
  static StartZoneDelayTimerEvent? _defaultInstance;

  @$pb.TagNumber(1)
  ZoneState get currentZone => $_getN(0);
  @$pb.TagNumber(1)
  set currentZone(ZoneState v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrentZone() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentZone() => clearField(1);
  @$pb.TagNumber(1)
  ZoneState ensureCurrentZone() => $_ensure(0);

  @$pb.TagNumber(2)
  ZoneState get nextZone => $_getN(1);
  @$pb.TagNumber(2)
  set nextZone(ZoneState v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextZone() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextZone() => clearField(2);
  @$pb.TagNumber(2)
  ZoneState ensureNextZone() => $_ensure(1);

  @$pb.TagNumber(3)
  $fixnum.Int64 get zoneTickStartTimestamp => $_getI64(2);
  @$pb.TagNumber(3)
  set zoneTickStartTimestamp($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasZoneTickStartTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearZoneTickStartTimestamp() => clearField(3);
}

class ZoneTickEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ZoneTickEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOM<ZoneState>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentZone', subBuilder: ZoneState.create)
    ..aOM<ZoneState>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextZone', subBuilder: ZoneState.create)
    ..hasRequiredFields = false
  ;

  ZoneTickEvent._() : super();
  factory ZoneTickEvent({
    ZoneState? currentZone,
    ZoneState? nextZone,
  }) {
    final _result = create();
    if (currentZone != null) {
      _result.currentZone = currentZone;
    }
    if (nextZone != null) {
      _result.nextZone = nextZone;
    }
    return _result;
  }
  factory ZoneTickEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ZoneTickEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ZoneTickEvent clone() => ZoneTickEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ZoneTickEvent copyWith(void Function(ZoneTickEvent) updates) => super.copyWith((message) => updates(message as ZoneTickEvent)) as ZoneTickEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ZoneTickEvent create() => ZoneTickEvent._();
  ZoneTickEvent createEmptyInstance() => create();
  static $pb.PbList<ZoneTickEvent> createRepeated() => $pb.PbList<ZoneTickEvent>();
  @$core.pragma('dart2js:noInline')
  static ZoneTickEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ZoneTickEvent>(create);
  static ZoneTickEvent? _defaultInstance;

  @$pb.TagNumber(1)
  ZoneState get currentZone => $_getN(0);
  @$pb.TagNumber(1)
  set currentZone(ZoneState v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrentZone() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentZone() => clearField(1);
  @$pb.TagNumber(1)
  ZoneState ensureCurrentZone() => $_ensure(0);

  @$pb.TagNumber(2)
  ZoneState get nextZone => $_getN(1);
  @$pb.TagNumber(2)
  set nextZone(ZoneState v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextZone() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextZone() => clearField(2);
  @$pb.TagNumber(2)
  ZoneState ensureNextZone() => $_ensure(1);
}

class PlayerState extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PlayerState', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'playerUuid')
    ..aOM<Position>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', subBuilder: Position.create)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'health', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  PlayerState._() : super();
  factory PlayerState({
    $core.String? playerUuid,
    Position? position,
    $core.int? health,
  }) {
    final _result = create();
    if (playerUuid != null) {
      _result.playerUuid = playerUuid;
    }
    if (position != null) {
      _result.position = position;
    }
    if (health != null) {
      _result.health = health;
    }
    return _result;
  }
  factory PlayerState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlayerState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlayerState clone() => PlayerState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlayerState copyWith(void Function(PlayerState) updates) => super.copyWith((message) => updates(message as PlayerState)) as PlayerState; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PlayerState create() => PlayerState._();
  PlayerState createEmptyInstance() => create();
  static $pb.PbList<PlayerState> createRepeated() => $pb.PbList<PlayerState>();
  @$core.pragma('dart2js:noInline')
  static PlayerState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayerState>(create);
  static PlayerState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get playerUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set playerUuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlayerUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayerUuid() => clearField(1);

  @$pb.TagNumber(2)
  Position get position => $_getN(1);
  @$pb.TagNumber(2)
  set position(Position v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearPosition() => clearField(2);
  @$pb.TagNumber(2)
  Position ensurePosition() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get health => $_getIZ(2);
  @$pb.TagNumber(3)
  set health($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHealth() => $_has(2);
  @$pb.TagNumber(3)
  void clearHealth() => clearField(3);
}

class ZoneState extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ZoneState', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOM<Position>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', subBuilder: Position.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'radiusInM', $pb.PbFieldType.O3)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'damage', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  ZoneState._() : super();
  factory ZoneState({
    Position? position,
    $core.int? radiusInM,
    $core.double? damage,
  }) {
    final _result = create();
    if (position != null) {
      _result.position = position;
    }
    if (radiusInM != null) {
      _result.radiusInM = radiusInM;
    }
    if (damage != null) {
      _result.damage = damage;
    }
    return _result;
  }
  factory ZoneState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ZoneState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ZoneState clone() => ZoneState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ZoneState copyWith(void Function(ZoneState) updates) => super.copyWith((message) => updates(message as ZoneState)) as ZoneState; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ZoneState create() => ZoneState._();
  ZoneState createEmptyInstance() => create();
  static $pb.PbList<ZoneState> createRepeated() => $pb.PbList<ZoneState>();
  @$core.pragma('dart2js:noInline')
  static ZoneState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ZoneState>(create);
  static ZoneState? _defaultInstance;

  @$pb.TagNumber(1)
  Position get position => $_getN(0);
  @$pb.TagNumber(1)
  set position(Position v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPosition() => $_has(0);
  @$pb.TagNumber(1)
  void clearPosition() => clearField(1);
  @$pb.TagNumber(1)
  Position ensurePosition() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get radiusInM => $_getIZ(1);
  @$pb.TagNumber(2)
  set radiusInM($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRadiusInM() => $_has(1);
  @$pb.TagNumber(2)
  void clearRadiusInM() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get damage => $_getN(2);
  @$pb.TagNumber(3)
  set damage($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDamage() => $_has(2);
  @$pb.TagNumber(3)
  void clearDamage() => clearField(3);
}

class Position extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Position', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'longitude', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'latitude', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Position._() : super();
  factory Position({
    $core.double? longitude,
    $core.double? latitude,
  }) {
    final _result = create();
    if (longitude != null) {
      _result.longitude = longitude;
    }
    if (latitude != null) {
      _result.latitude = latitude;
    }
    return _result;
  }
  factory Position.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Position.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Position clone() => Position()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Position copyWith(void Function(Position) updates) => super.copyWith((message) => updates(message as Position)) as Position; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Position create() => Position._();
  Position createEmptyInstance() => create();
  static $pb.PbList<Position> createRepeated() => $pb.PbList<Position>();
  @$core.pragma('dart2js:noInline')
  static Position getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Position>(create);
  static Position? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get longitude => $_getN(0);
  @$pb.TagNumber(1)
  set longitude($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLongitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLongitude() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get latitude => $_getN(1);
  @$pb.TagNumber(2)
  set latitude($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLatitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLatitude() => clearField(2);
}

