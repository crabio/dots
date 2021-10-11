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
  ],
};

/// Descriptor for `CreateSpotRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSpotRequestDescriptor = $convert.base64Decode('ChFDcmVhdGVTcG90UmVxdWVzdBIcCglsb25naXR1ZGUYASABKAFSCWxvbmdpdHVkZRIcCglsYXRpaXR1ZGUYAiABKAFSCWxhdGlpdHVkZQ==');
@$core.Deprecated('Use createSpotResponseDescriptor instead')
const CreateSpotResponse$json = const {
  '1': 'CreateSpotResponse',
  '2': const [
    const {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'longitude', '3': 2, '4': 1, '5': 1, '10': 'longitude'},
    const {'1': 'latiitude', '3': 3, '4': 1, '5': 1, '10': 'latiitude'},
  ],
};

/// Descriptor for `CreateSpotResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSpotResponseDescriptor = $convert.base64Decode('ChJDcmVhdGVTcG90UmVzcG9uc2USEgoEdXVpZBgBIAEoCVIEdXVpZBIcCglsb25naXR1ZGUYAiABKAFSCWxvbmdpdHVkZRIcCglsYXRpaXR1ZGUYAyABKAFSCWxhdGlpdHVkZQ==');
