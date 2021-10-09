// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.27.1
// 	protoc        v3.17.3
// source: spot/v1/spot_v1.proto

package user

import (
	_ "google.golang.org/genproto/googleapis/api/annotations"
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	reflect "reflect"
	sync "sync"
)

const (
	// Verify that this generated code is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(20 - protoimpl.MinVersion)
	// Verify that runtime/protoimpl is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(protoimpl.MaxVersion - 20)
)

type CreateSpotRequest struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields
}

func (x *CreateSpotRequest) Reset() {
	*x = CreateSpotRequest{}
	if protoimpl.UnsafeEnabled {
		mi := &file_spot_v1_spot_v1_proto_msgTypes[0]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *CreateSpotRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*CreateSpotRequest) ProtoMessage() {}

func (x *CreateSpotRequest) ProtoReflect() protoreflect.Message {
	mi := &file_spot_v1_spot_v1_proto_msgTypes[0]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use CreateSpotRequest.ProtoReflect.Descriptor instead.
func (*CreateSpotRequest) Descriptor() ([]byte, []int) {
	return file_spot_v1_spot_v1_proto_rawDescGZIP(), []int{0}
}

type CreateSpotResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Id uint32 `protobuf:"varint,1,opt,name=id,proto3" json:"id,omitempty"`
}

func (x *CreateSpotResponse) Reset() {
	*x = CreateSpotResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_spot_v1_spot_v1_proto_msgTypes[1]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *CreateSpotResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*CreateSpotResponse) ProtoMessage() {}

func (x *CreateSpotResponse) ProtoReflect() protoreflect.Message {
	mi := &file_spot_v1_spot_v1_proto_msgTypes[1]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use CreateSpotResponse.ProtoReflect.Descriptor instead.
func (*CreateSpotResponse) Descriptor() ([]byte, []int) {
	return file_spot_v1_spot_v1_proto_rawDescGZIP(), []int{1}
}

func (x *CreateSpotResponse) GetId() uint32 {
	if x != nil {
		return x.Id
	}
	return 0
}

var File_spot_v1_spot_v1_proto protoreflect.FileDescriptor

var file_spot_v1_spot_v1_proto_rawDesc = []byte{
	0x0a, 0x15, 0x73, 0x70, 0x6f, 0x74, 0x2f, 0x76, 0x31, 0x2f, 0x73, 0x70, 0x6f, 0x74, 0x5f, 0x76,
	0x31, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x12, 0x07, 0x73, 0x70, 0x6f, 0x74, 0x2e, 0x76, 0x31,
	0x1a, 0x1c, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2f, 0x61, 0x70, 0x69, 0x2f, 0x61, 0x6e, 0x6e,
	0x6f, 0x74, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x73, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x22, 0x13,
	0x0a, 0x11, 0x43, 0x72, 0x65, 0x61, 0x74, 0x65, 0x53, 0x70, 0x6f, 0x74, 0x52, 0x65, 0x71, 0x75,
	0x65, 0x73, 0x74, 0x22, 0x24, 0x0a, 0x12, 0x43, 0x72, 0x65, 0x61, 0x74, 0x65, 0x53, 0x70, 0x6f,
	0x74, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x0e, 0x0a, 0x02, 0x69, 0x64, 0x18,
	0x01, 0x20, 0x01, 0x28, 0x0d, 0x52, 0x02, 0x69, 0x64, 0x32, 0x6d, 0x0a, 0x0b, 0x53, 0x70, 0x6f,
	0x74, 0x53, 0x65, 0x72, 0x76, 0x69, 0x63, 0x65, 0x12, 0x5e, 0x0a, 0x0a, 0x43, 0x72, 0x65, 0x61,
	0x74, 0x65, 0x53, 0x70, 0x6f, 0x74, 0x12, 0x1a, 0x2e, 0x73, 0x70, 0x6f, 0x74, 0x2e, 0x76, 0x31,
	0x2e, 0x43, 0x72, 0x65, 0x61, 0x74, 0x65, 0x53, 0x70, 0x6f, 0x74, 0x52, 0x65, 0x71, 0x75, 0x65,
	0x73, 0x74, 0x1a, 0x1b, 0x2e, 0x73, 0x70, 0x6f, 0x74, 0x2e, 0x76, 0x31, 0x2e, 0x43, 0x72, 0x65,
	0x61, 0x74, 0x65, 0x53, 0x70, 0x6f, 0x74, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x22,
	0x17, 0x82, 0xd3, 0xe4, 0x93, 0x02, 0x11, 0x22, 0x0c, 0x2f, 0x61, 0x70, 0x69, 0x2f, 0x76, 0x31,
	0x2f, 0x73, 0x70, 0x6f, 0x74, 0x3a, 0x01, 0x2a, 0x42, 0x33, 0x5a, 0x31, 0x67, 0x69, 0x74, 0x68,
	0x75, 0x62, 0x2e, 0x63, 0x6f, 0x6d, 0x2f, 0x69, 0x61, 0x6b, 0x72, 0x65, 0x76, 0x65, 0x74, 0x6b,
	0x68, 0x6f, 0x2f, 0x61, 0x72, 0x63, 0x68, 0x61, 0x65, 0x6f, 0x70, 0x74, 0x65, 0x72, 0x79, 0x78,
	0x5f, 0x65, 0x78, 0x61, 0x6d, 0x70, 0x6c, 0x65, 0x3b, 0x75, 0x73, 0x65, 0x72, 0x62, 0x06, 0x70,
	0x72, 0x6f, 0x74, 0x6f, 0x33,
}

var (
	file_spot_v1_spot_v1_proto_rawDescOnce sync.Once
	file_spot_v1_spot_v1_proto_rawDescData = file_spot_v1_spot_v1_proto_rawDesc
)

func file_spot_v1_spot_v1_proto_rawDescGZIP() []byte {
	file_spot_v1_spot_v1_proto_rawDescOnce.Do(func() {
		file_spot_v1_spot_v1_proto_rawDescData = protoimpl.X.CompressGZIP(file_spot_v1_spot_v1_proto_rawDescData)
	})
	return file_spot_v1_spot_v1_proto_rawDescData
}

var file_spot_v1_spot_v1_proto_msgTypes = make([]protoimpl.MessageInfo, 2)
var file_spot_v1_spot_v1_proto_goTypes = []interface{}{
	(*CreateSpotRequest)(nil),  // 0: spot.v1.CreateSpotRequest
	(*CreateSpotResponse)(nil), // 1: spot.v1.CreateSpotResponse
}
var file_spot_v1_spot_v1_proto_depIdxs = []int32{
	0, // 0: spot.v1.SpotService.CreateSpot:input_type -> spot.v1.CreateSpotRequest
	1, // 1: spot.v1.SpotService.CreateSpot:output_type -> spot.v1.CreateSpotResponse
	1, // [1:2] is the sub-list for method output_type
	0, // [0:1] is the sub-list for method input_type
	0, // [0:0] is the sub-list for extension type_name
	0, // [0:0] is the sub-list for extension extendee
	0, // [0:0] is the sub-list for field type_name
}

func init() { file_spot_v1_spot_v1_proto_init() }
func file_spot_v1_spot_v1_proto_init() {
	if File_spot_v1_spot_v1_proto != nil {
		return
	}
	if !protoimpl.UnsafeEnabled {
		file_spot_v1_spot_v1_proto_msgTypes[0].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*CreateSpotRequest); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_spot_v1_spot_v1_proto_msgTypes[1].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*CreateSpotResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
	}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: file_spot_v1_spot_v1_proto_rawDesc,
			NumEnums:      0,
			NumMessages:   2,
			NumExtensions: 0,
			NumServices:   1,
		},
		GoTypes:           file_spot_v1_spot_v1_proto_goTypes,
		DependencyIndexes: file_spot_v1_spot_v1_proto_depIdxs,
		MessageInfos:      file_spot_v1_spot_v1_proto_msgTypes,
	}.Build()
	File_spot_v1_spot_v1_proto = out.File
	file_spot_v1_spot_v1_proto_rawDesc = nil
	file_spot_v1_spot_v1_proto_goTypes = nil
	file_spot_v1_spot_v1_proto_depIdxs = nil
}
