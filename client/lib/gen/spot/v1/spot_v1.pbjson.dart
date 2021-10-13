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
    const {'1': 'longitude', '3': 1, '4': 1, '5': 1, '10': 'longitude'},
    const {'1': 'latiitude', '3': 2, '4': 1, '5': 1, '10': 'latiitude'},
    const {'1': 'radius', '3': 3, '4': 1, '5': 5, '10': 'radius'},
    const {'1': 'scanPeriodInSeconds', '3': 4, '4': 1, '5': 5, '10': 'scanPeriodInSeconds'},
    const {'1': 'zonePeriodInSeconds', '3': 5, '4': 1, '5': 5, '10': 'zonePeriodInSeconds'},
  ],
};

/// Descriptor for `CreateSpotRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSpotRequestDescriptor = $convert.base64Decode('ChFDcmVhdGVTcG90UmVxdWVzdBIcCglsb25naXR1ZGUYASABKAFSCWxvbmdpdHVkZRIcCglsYXRpaXR1ZGUYAiABKAFSCWxhdGlpdHVkZRIWCgZyYWRpdXMYAyABKAVSBnJhZGl1cxIwChNzY2FuUGVyaW9kSW5TZWNvbmRzGAQgASgFUhNzY2FuUGVyaW9kSW5TZWNvbmRzEjAKE3pvbmVQZXJpb2RJblNlY29uZHMYBSABKAVSE3pvbmVQZXJpb2RJblNlY29uZHM=');
@$core.Deprecated('Use createSpotResponseDescriptor instead')
const CreateSpotResponse$json = const {
  '1': 'CreateSpotResponse',
  '2': const [
    const {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
  ],
};

/// Descriptor for `CreateSpotResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSpotResponseDescriptor = $convert.base64Decode('ChJDcmVhdGVTcG90UmVzcG9uc2USEgoEdXVpZBgBIAEoCVIEdXVpZA==');
@$core.Deprecated('Use getSpotRequestDescriptor instead')
const GetSpotRequest$json = const {
  '1': 'GetSpotRequest',
  '2': const [
    const {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
  ],
};

/// Descriptor for `GetSpotRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSpotRequestDescriptor = $convert.base64Decode('Cg5HZXRTcG90UmVxdWVzdBISCgR1dWlkGAEgASgJUgR1dWlk');
@$core.Deprecated('Use getSpotResponseDescriptor instead')
const GetSpotResponse$json = const {
  '1': 'GetSpotResponse',
  '2': const [
    const {'1': 'longitude', '3': 1, '4': 1, '5': 1, '10': 'longitude'},
    const {'1': 'latiitude', '3': 2, '4': 1, '5': 1, '10': 'latiitude'},
    const {'1': 'radius', '3': 3, '4': 1, '5': 5, '10': 'radius'},
    const {'1': 'scanPeriodInSeconds', '3': 4, '4': 1, '5': 5, '10': 'scanPeriodInSeconds'},
    const {'1': 'zonePeriodInSeconds', '3': 5, '4': 1, '5': 5, '10': 'zonePeriodInSeconds'},
  ],
};

/// Descriptor for `GetSpotResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSpotResponseDescriptor = $convert.base64Decode('Cg9HZXRTcG90UmVzcG9uc2USHAoJbG9uZ2l0dWRlGAEgASgBUglsb25naXR1ZGUSHAoJbGF0aWl0dWRlGAIgASgBUglsYXRpaXR1ZGUSFgoGcmFkaXVzGAMgASgFUgZyYWRpdXMSMAoTc2NhblBlcmlvZEluU2Vjb25kcxgEIAEoBVITc2NhblBlcmlvZEluU2Vjb25kcxIwChN6b25lUGVyaW9kSW5TZWNvbmRzGAUgASgFUhN6b25lUGVyaW9kSW5TZWNvbmRz');
