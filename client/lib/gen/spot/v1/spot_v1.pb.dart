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
    ..hasRequiredFields = false
  ;

  CreateSpotRequest._() : super();
  factory CreateSpotRequest({
    Position? position,
    $core.int? radius,
    $core.int? scanPeriodInSeconds,
    $core.int? zonePeriodInSeconds,
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
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'radius', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scanPeriodInSeconds', $pb.PbFieldType.O3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'zonePeriodInSeconds', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetSpotResponse._() : super();
  factory GetSpotResponse({
    Position? position,
    $core.int? radius,
    $core.int? scanPeriodInSeconds,
    $core.int? zonePeriodInSeconds,
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

  @$pb.TagNumber(3)
  $core.int get radius => $_getIZ(1);
  @$pb.TagNumber(3)
  set radius($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasRadius() => $_has(1);
  @$pb.TagNumber(3)
  void clearRadius() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get scanPeriodInSeconds => $_getIZ(2);
  @$pb.TagNumber(4)
  set scanPeriodInSeconds($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasScanPeriodInSeconds() => $_has(2);
  @$pb.TagNumber(4)
  void clearScanPeriodInSeconds() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get zonePeriodInSeconds => $_getIZ(3);
  @$pb.TagNumber(5)
  set zonePeriodInSeconds($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasZonePeriodInSeconds() => $_has(3);
  @$pb.TagNumber(5)
  void clearZonePeriodInSeconds() => clearField(5);
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

class GetPlayersPositionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPlayersPositionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'spotUuid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'playerUuid')
    ..hasRequiredFields = false
  ;

  GetPlayersPositionsRequest._() : super();
  factory GetPlayersPositionsRequest({
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
  factory GetPlayersPositionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPlayersPositionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPlayersPositionsRequest clone() => GetPlayersPositionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPlayersPositionsRequest copyWith(void Function(GetPlayersPositionsRequest) updates) => super.copyWith((message) => updates(message as GetPlayersPositionsRequest)) as GetPlayersPositionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPlayersPositionsRequest create() => GetPlayersPositionsRequest._();
  GetPlayersPositionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPlayersPositionsRequest> createRepeated() => $pb.PbList<GetPlayersPositionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPlayersPositionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPlayersPositionsRequest>(create);
  static GetPlayersPositionsRequest? _defaultInstance;

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

class GetPlayersPositionsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPlayersPositionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOM<Position>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'playerPosition', subBuilder: Position.create)
    ..pc<PlayerPosition>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'otherPlayersPositions', $pb.PbFieldType.PM, subBuilder: PlayerPosition.create)
    ..hasRequiredFields = false
  ;

  GetPlayersPositionsResponse._() : super();
  factory GetPlayersPositionsResponse({
    Position? playerPosition,
    $core.Iterable<PlayerPosition>? otherPlayersPositions,
  }) {
    final _result = create();
    if (playerPosition != null) {
      _result.playerPosition = playerPosition;
    }
    if (otherPlayersPositions != null) {
      _result.otherPlayersPositions.addAll(otherPlayersPositions);
    }
    return _result;
  }
  factory GetPlayersPositionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPlayersPositionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPlayersPositionsResponse clone() => GetPlayersPositionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPlayersPositionsResponse copyWith(void Function(GetPlayersPositionsResponse) updates) => super.copyWith((message) => updates(message as GetPlayersPositionsResponse)) as GetPlayersPositionsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPlayersPositionsResponse create() => GetPlayersPositionsResponse._();
  GetPlayersPositionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPlayersPositionsResponse> createRepeated() => $pb.PbList<GetPlayersPositionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPlayersPositionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPlayersPositionsResponse>(create);
  static GetPlayersPositionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Position get playerPosition => $_getN(0);
  @$pb.TagNumber(1)
  set playerPosition(Position v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlayerPosition() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayerPosition() => clearField(1);
  @$pb.TagNumber(1)
  Position ensurePlayerPosition() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<PlayerPosition> get otherPlayersPositions => $_getList(1);
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

class PlayerPosition extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PlayerPosition', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spot.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'playerUuid')
    ..aOM<Position>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', subBuilder: Position.create)
    ..hasRequiredFields = false
  ;

  PlayerPosition._() : super();
  factory PlayerPosition({
    $core.String? playerUuid,
    Position? position,
  }) {
    final _result = create();
    if (playerUuid != null) {
      _result.playerUuid = playerUuid;
    }
    if (position != null) {
      _result.position = position;
    }
    return _result;
  }
  factory PlayerPosition.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlayerPosition.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlayerPosition clone() => PlayerPosition()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlayerPosition copyWith(void Function(PlayerPosition) updates) => super.copyWith((message) => updates(message as PlayerPosition)) as PlayerPosition; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PlayerPosition create() => PlayerPosition._();
  PlayerPosition createEmptyInstance() => create();
  static $pb.PbList<PlayerPosition> createRepeated() => $pb.PbList<PlayerPosition>();
  @$core.pragma('dart2js:noInline')
  static PlayerPosition getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayerPosition>(create);
  static PlayerPosition? _defaultInstance;

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
}

