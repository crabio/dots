// Mocks generated by Mockito 5.0.16 from annotations
// in dots_client/test/pages/main/bloc/bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:geolocator_platform_interface/geolocator_platform_interface.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakePosition_0 extends _i1.Fake implements _i2.Position {}

/// A class which mocks [GeolocatorPlatform].
///
/// See the documentation for Mockito's code generation for more information.
class MockGeolocatorPlatform extends _i1.Mock
    implements _i2.GeolocatorPlatform {
  MockGeolocatorPlatform() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i2.LocationPermission> checkPermission() =>
      (super.noSuchMethod(Invocation.method(#checkPermission, []),
              returnValue: Future<_i2.LocationPermission>.value(
                  _i2.LocationPermission.denied))
          as _i3.Future<_i2.LocationPermission>);
  @override
  _i3.Future<_i2.LocationPermission> requestPermission() =>
      (super.noSuchMethod(Invocation.method(#requestPermission, []),
              returnValue: Future<_i2.LocationPermission>.value(
                  _i2.LocationPermission.denied))
          as _i3.Future<_i2.LocationPermission>);
  @override
  _i3.Future<bool> isLocationServiceEnabled() =>
      (super.noSuchMethod(Invocation.method(#isLocationServiceEnabled, []),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
  @override
  _i3.Future<_i2.Position?> getLastKnownPosition(
          {bool? forceAndroidLocationManager = false}) =>
      (super.noSuchMethod(
              Invocation.method(#getLastKnownPosition, [],
                  {#forceAndroidLocationManager: forceAndroidLocationManager}),
              returnValue: Future<_i2.Position?>.value())
          as _i3.Future<_i2.Position?>);
  @override
  _i3.Future<_i2.Position> getCurrentPosition(
          {_i2.LocationSettings? locationSettings}) =>
      (super.noSuchMethod(
              Invocation.method(#getCurrentPosition, [],
                  {#locationSettings: locationSettings}),
              returnValue: Future<_i2.Position>.value(_FakePosition_0()))
          as _i3.Future<_i2.Position>);
  @override
  _i3.Stream<_i2.ServiceStatus> getServiceStatusStream() =>
      (super.noSuchMethod(Invocation.method(#getServiceStatusStream, []),
              returnValue: Stream<_i2.ServiceStatus>.empty())
          as _i3.Stream<_i2.ServiceStatus>);
  @override
  _i3.Stream<_i2.Position> getPositionStream(
          {_i2.LocationSettings? locationSettings}) =>
      (super.noSuchMethod(
          Invocation.method(
              #getPositionStream, [], {#locationSettings: locationSettings}),
          returnValue:
              Stream<_i2.Position>.empty()) as _i3.Stream<_i2.Position>);
  @override
  _i3.Future<_i2.LocationAccuracyStatus> requestTemporaryFullAccuracy(
          {String? purposeKey}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #requestTemporaryFullAccuracy, [], {#purposeKey: purposeKey}),
              returnValue: Future<_i2.LocationAccuracyStatus>.value(
                  _i2.LocationAccuracyStatus.reduced))
          as _i3.Future<_i2.LocationAccuracyStatus>);
  @override
  _i3.Future<_i2.LocationAccuracyStatus> getLocationAccuracy() =>
      (super.noSuchMethod(Invocation.method(#getLocationAccuracy, []),
              returnValue: Future<_i2.LocationAccuracyStatus>.value(
                  _i2.LocationAccuracyStatus.reduced))
          as _i3.Future<_i2.LocationAccuracyStatus>);
  @override
  _i3.Future<bool> openAppSettings() =>
      (super.noSuchMethod(Invocation.method(#openAppSettings, []),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
  @override
  _i3.Future<bool> openLocationSettings() =>
      (super.noSuchMethod(Invocation.method(#openLocationSettings, []),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
  @override
  double distanceBetween(double? startLatitude, double? startLongitude,
          double? endLatitude, double? endLongitude) =>
      (super.noSuchMethod(
          Invocation.method(#distanceBetween,
              [startLatitude, startLongitude, endLatitude, endLongitude]),
          returnValue: 0.0) as double);
  @override
  double bearingBetween(double? startLatitude, double? startLongitude,
          double? endLatitude, double? endLongitude) =>
      (super.noSuchMethod(
          Invocation.method(#bearingBetween,
              [startLatitude, startLongitude, endLatitude, endLongitude]),
          returnValue: 0.0) as double);
  @override
  String toString() => super.toString();
}
