# install:
# 	@echo "Install Buf generators"
# 	go get \
# 		google.golang.org/protobuf/cmd/protoc-gen-go \
# 		google.golang.org/grpc/cmd/protoc-gen-go-grpc \
# 		github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway \
# 		github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2
# 	go install \
# 		google.golang.org/protobuf/cmd/protoc-gen-go \
# 		google.golang.org/grpc/cmd/protoc-gen-go-grpc \
# 		github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway \
# 		github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2
# 	curl -sSL \
#     	"https://github.com/bufbuild/buf/releases/download/v0.48.2/buf-$(shell uname -s)-$(shell uname -m)" \
#     	-o "$(shell go env GOPATH)/bin/buf" && \
#   	chmod +x "$(shell go env GOPATH)/bin/buf"

# 	echo "Install linter"
# 	curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(shell go env GOPATH)/bin v1.42.0

generate:
	@echo "Generate flutter files"
	flutter pub run build_runner build

lint:
	@echo "Run linter"
	flutter analyze

test:
	@echo "Run unit tests"
	flutter test