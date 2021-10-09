install:
	@echo "Activate protobuf plugin"
	dart pub global activate protoc_plugin

generate:
	@echo "Generate flutter files"
	flutter pub run build_runner build
	@echo "Generate protobuf files"
	protoc --dart_out=grpc:lib/gen -I ../server/proto/ $$(find ../server/proto -iname "*.proto")

lint:
	@echo "Run linter"
	flutter analyze

test:
	@echo "Run unit tests"
	flutter test