install:
	@echo "Activate protobuf plugin"
	dart pub global activate protoc_plugin 20.0.0

generate:
	@echo "Update Dart packages"
	dart pub get
	@echo "Update Flutter packages"
	flutter pub get
	@echo "Generate flutter files"
	flutter pub run build_runner build --delete-conflicting-outputs
	@echo "Generate protobuf files"
	protoc --dart_out=grpc:lib/gen -I ../server/proto/ $$(find ../server/proto -iname "*.proto")
	protoc --dart_out=lib/data/gen -I lib/data/ $$(find lib/data/ -iname "*.proto")

lint:
	@echo "Run linter"
	flutter analyze

unit-test:
	@echo "Run unit tests"
	flutter test --coverage

run:
	@echo "Run app"
	flutter run