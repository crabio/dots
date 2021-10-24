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
    ..aOM<Position>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', subBuilder: Position.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'radius', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scanPeriodInSeconds', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'zonePeriodInSeconds', $pb.PbFieldType.O3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionDurationInSeconds', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  CreateSpotRequest._() : super();
  factory CreateSpotRequest({
    Position? position,
    $core.int? radius,
    $core.int? scanPeriodInSeconds,
    $core.int? zonePeriodInSeconds,
    $core.int? sessionDurationInSeconds,
  }) {
    final _result = create();
    if (position != null) {
      _result.position = position;
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
    if (sessionDurationInSeconds != null) {
      _result.sessionDurationInSeconds = sessionDurationInSeconds;
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
  $core.int get radius => $_getIZ(1);
  @$pb.TagNumber(2)
  set radius($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRadius() => $_has(1);
  @$pb.TagNumber(2)
  void clearRadius() => clearField(2);

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

  @$pb.TagNumber(5)
  $core.int get sessionDurationInSeconds => $_getIZ(4);
  @$pb.TagNumber(5)
  set sessionDurationInSeconds($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSessionDurationInSeconds() => $_has(4);
  @$pb.TagNumber(5)
  void clearSessionDurationInSeconds() => clearField(5);
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
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'radius', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scanPeriodInSeconds', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'zonePeriodInSeconds', $pb.PbFieldType.O3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionDurationInSeconds', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetSpotResponse._() : super();
  factory GetSpotResponse({
    Position? position,
    $core.int? radius,
    $core.int? scanPeriodInSeconds,
    $core.int? zonePeriodInSeconds,
    $core.int? sessionDurationInSeconds,
  }) {
    final _result = create();
    if (position != null) {
      _result.position = position;
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
    if (sessionDurationInSeconds != null) {
      _result.sessionDurationInSeconds = sessionDurationInSeconds;
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
  $core.int get radius => $_getIZ(1);
  @$pb.TagNumber(2)
  set radius($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRadius() => $_has(1);
  @$pb.TagNumber(2)
  void clearRadius() => clearField(2);

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

  @$pb.TagNumber(5)
  $core.int get sessionDurationInSeconds => $_getIZ(4);
  @$pb.TagNumber(5)
  set sessionDurationInSeconds($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSessionDurationInSeconds() => $_has(4);
  @$pb.TagNumber(5)
  void clearSessionDurationInSeconds() => clearField(5);
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

