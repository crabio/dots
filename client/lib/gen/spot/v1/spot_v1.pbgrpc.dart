///
//  Generated code. Do not modify.
//  source: spot/v1/spot_v1.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'spot_v1.pb.dart' as $0;
export 'spot_v1.pb.dart';

class SpotServiceClient extends $grpc.Client {
  static final _$createSpot =
      $grpc.ClientMethod<$0.CreateSpotRequest, $0.CreateSpotResponse>(
          '/spot.v1.SpotService/CreateSpot',
          ($0.CreateSpotRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateSpotResponse.fromBuffer(value));
  static final _$getSpot =
      $grpc.ClientMethod<$0.GetSpotRequest, $0.GetSpotResponse>(
          '/spot.v1.SpotService/GetSpot',
          ($0.GetSpotRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetSpotResponse.fromBuffer(value));
  static final _$joinToSpot =
      $grpc.ClientMethod<$0.JoinToSpotRequest, $0.JoinToSpotResponse>(
          '/spot.v1.SpotService/JoinToSpot',
          ($0.JoinToSpotRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.JoinToSpotResponse.fromBuffer(value));
  static final _$getSpotPlayers =
      $grpc.ClientMethod<$0.GetSpotPlayersRequest, $0.GetSpotPlayersResponse>(
          '/spot.v1.SpotService/GetSpotPlayers',
          ($0.GetSpotPlayersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetSpotPlayersResponse.fromBuffer(value));
  static final _$startSpot =
      $grpc.ClientMethod<$0.StartSpotRequest, $0.StartSpotResponse>(
          '/spot.v1.SpotService/StartSpot',
          ($0.StartSpotRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.StartSpotResponse.fromBuffer(value));
  static final _$isPlayerHunter =
      $grpc.ClientMethod<$0.IsPlayerHunterRequest, $0.IsPlayerHunterResponse>(
          '/spot.v1.SpotService/IsPlayerHunter',
          ($0.IsPlayerHunterRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.IsPlayerHunterResponse.fromBuffer(value));
  static final _$getSpotStartFlag = $grpc.ClientMethod<
          $0.GetSpotStartFlagRequest, $0.GetSpotStartFlagResponse>(
      '/spot.v1.SpotService/GetSpotStartFlag',
      ($0.GetSpotStartFlagRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetSpotStartFlagResponse.fromBuffer(value));
  static final _$sendPlayerPosition = $grpc.ClientMethod<
          $0.SendPlayerPositionRequest, $0.SendPlayerPositionResponse>(
      '/spot.v1.SpotService/SendPlayerPosition',
      ($0.SendPlayerPositionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SendPlayerPositionResponse.fromBuffer(value));
  static final _$getPlayersStates = $grpc.ClientMethod<
          $0.GetPlayersStatesRequest, $0.GetPlayersStatesResponse>(
      '/spot.v1.SpotService/GetPlayersStates',
      ($0.GetPlayersStatesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetPlayersStatesResponse.fromBuffer(value));
  static final _$subZoneEvent =
      $grpc.ClientMethod<$0.SubZoneEventRequest, $0.SubZoneEventResponse>(
          '/spot.v1.SpotService/SubZoneEvent',
          ($0.SubZoneEventRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SubZoneEventResponse.fromBuffer(value));

  SpotServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateSpotResponse> createSpot(
      $0.CreateSpotRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createSpot, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSpotResponse> getSpot($0.GetSpotRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSpot, request, options: options);
  }

  $grpc.ResponseFuture<$0.JoinToSpotResponse> joinToSpot(
      $0.JoinToSpotRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$joinToSpot, request, options: options);
  }

  $grpc.ResponseStream<$0.GetSpotPlayersResponse> getSpotPlayers(
      $0.GetSpotPlayersRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$getSpotPlayers, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.StartSpotResponse> startSpot(
      $0.StartSpotRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$startSpot, request, options: options);
  }

  $grpc.ResponseFuture<$0.IsPlayerHunterResponse> isPlayerHunter(
      $0.IsPlayerHunterRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$isPlayerHunter, request, options: options);
  }

  $grpc.ResponseStream<$0.GetSpotStartFlagResponse> getSpotStartFlag(
      $0.GetSpotStartFlagRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$getSpotStartFlag, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.SendPlayerPositionResponse> sendPlayerPosition(
      $async.Stream<$0.SendPlayerPositionRequest> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$sendPlayerPosition, request, options: options)
        .single;
  }

  $grpc.ResponseStream<$0.GetPlayersStatesResponse> getPlayersStates(
      $0.GetPlayersStatesRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$getPlayersStates, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$0.SubZoneEventResponse> subZoneEvent(
      $0.SubZoneEventRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$subZoneEvent, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class SpotServiceBase extends $grpc.Service {
  $core.String get $name => 'spot.v1.SpotService';

  SpotServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateSpotRequest, $0.CreateSpotResponse>(
        'CreateSpot',
        createSpot_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateSpotRequest.fromBuffer(value),
        ($0.CreateSpotResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSpotRequest, $0.GetSpotResponse>(
        'GetSpot',
        getSpot_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetSpotRequest.fromBuffer(value),
        ($0.GetSpotResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.JoinToSpotRequest, $0.JoinToSpotResponse>(
        'JoinToSpot',
        joinToSpot_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.JoinToSpotRequest.fromBuffer(value),
        ($0.JoinToSpotResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSpotPlayersRequest,
            $0.GetSpotPlayersResponse>(
        'GetSpotPlayers',
        getSpotPlayers_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.GetSpotPlayersRequest.fromBuffer(value),
        ($0.GetSpotPlayersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StartSpotRequest, $0.StartSpotResponse>(
        'StartSpot',
        startSpot_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StartSpotRequest.fromBuffer(value),
        ($0.StartSpotResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.IsPlayerHunterRequest,
            $0.IsPlayerHunterResponse>(
        'IsPlayerHunter',
        isPlayerHunter_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.IsPlayerHunterRequest.fromBuffer(value),
        ($0.IsPlayerHunterResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSpotStartFlagRequest,
            $0.GetSpotStartFlagResponse>(
        'GetSpotStartFlag',
        getSpotStartFlag_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.GetSpotStartFlagRequest.fromBuffer(value),
        ($0.GetSpotStartFlagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SendPlayerPositionRequest,
            $0.SendPlayerPositionResponse>(
        'SendPlayerPosition',
        sendPlayerPosition,
        true,
        false,
        ($core.List<$core.int> value) =>
            $0.SendPlayerPositionRequest.fromBuffer(value),
        ($0.SendPlayerPositionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPlayersStatesRequest,
            $0.GetPlayersStatesResponse>(
        'GetPlayersStates',
        getPlayersStates_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.GetPlayersStatesRequest.fromBuffer(value),
        ($0.GetPlayersStatesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.SubZoneEventRequest, $0.SubZoneEventResponse>(
            'SubZoneEvent',
            subZoneEvent_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $0.SubZoneEventRequest.fromBuffer(value),
            ($0.SubZoneEventResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateSpotResponse> createSpot_Pre($grpc.ServiceCall call,
      $async.Future<$0.CreateSpotRequest> request) async {
    return createSpot(call, await request);
  }

  $async.Future<$0.GetSpotResponse> getSpot_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GetSpotRequest> request) async {
    return getSpot(call, await request);
  }

  $async.Future<$0.JoinToSpotResponse> joinToSpot_Pre($grpc.ServiceCall call,
      $async.Future<$0.JoinToSpotRequest> request) async {
    return joinToSpot(call, await request);
  }

  $async.Stream<$0.GetSpotPlayersResponse> getSpotPlayers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetSpotPlayersRequest> request) async* {
    yield* getSpotPlayers(call, await request);
  }

  $async.Future<$0.StartSpotResponse> startSpot_Pre($grpc.ServiceCall call,
      $async.Future<$0.StartSpotRequest> request) async {
    return startSpot(call, await request);
  }

  $async.Future<$0.IsPlayerHunterResponse> isPlayerHunter_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.IsPlayerHunterRequest> request) async {
    return isPlayerHunter(call, await request);
  }

  $async.Stream<$0.GetSpotStartFlagResponse> getSpotStartFlag_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetSpotStartFlagRequest> request) async* {
    yield* getSpotStartFlag(call, await request);
  }

  $async.Stream<$0.GetPlayersStatesResponse> getPlayersStates_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetPlayersStatesRequest> request) async* {
    yield* getPlayersStates(call, await request);
  }

  $async.Stream<$0.SubZoneEventResponse> subZoneEvent_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SubZoneEventRequest> request) async* {
    yield* subZoneEvent(call, await request);
  }

  $async.Future<$0.CreateSpotResponse> createSpot(
      $grpc.ServiceCall call, $0.CreateSpotRequest request);
  $async.Future<$0.GetSpotResponse> getSpot(
      $grpc.ServiceCall call, $0.GetSpotRequest request);
  $async.Future<$0.JoinToSpotResponse> joinToSpot(
      $grpc.ServiceCall call, $0.JoinToSpotRequest request);
  $async.Stream<$0.GetSpotPlayersResponse> getSpotPlayers(
      $grpc.ServiceCall call, $0.GetSpotPlayersRequest request);
  $async.Future<$0.StartSpotResponse> startSpot(
      $grpc.ServiceCall call, $0.StartSpotRequest request);
  $async.Future<$0.IsPlayerHunterResponse> isPlayerHunter(
      $grpc.ServiceCall call, $0.IsPlayerHunterRequest request);
  $async.Stream<$0.GetSpotStartFlagResponse> getSpotStartFlag(
      $grpc.ServiceCall call, $0.GetSpotStartFlagRequest request);
  $async.Future<$0.SendPlayerPositionResponse> sendPlayerPosition(
      $grpc.ServiceCall call,
      $async.Stream<$0.SendPlayerPositionRequest> request);
  $async.Stream<$0.GetPlayersStatesResponse> getPlayersStates(
      $grpc.ServiceCall call, $0.GetPlayersStatesRequest request);
  $async.Stream<$0.SubZoneEventResponse> subZoneEvent(
      $grpc.ServiceCall call, $0.SubZoneEventRequest request);
}
