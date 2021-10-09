help:
	@echo "Makefile for the archaeopteryx."
	@echo "Available targets:"
	@echo " help - print help information"
	@echo " install - install required dependecies for the project"
	@echo " generate - generate proto files"
	@echo " lint - run linter"
	@echo " test - run unit tests"

install:
	@echo "Install Buf generators"
	go get \
		google.golang.org/protobuf/cmd/protoc-gen-go \
		google.golang.org/grpc/cmd/protoc-gen-go-grpc \
		github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway \
		github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2
	go install \
		google.golang.org/protobuf/cmd/protoc-gen-go \
		google.golang.org/grpc/cmd/protoc-gen-go-grpc \
		github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway \
		github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2
	curl -sSL \
    	"https://github.com/bufbuild/buf/releases/download/v0.48.2/buf-$(shell uname -s)-$(shell uname -m)" \
    	-o "$(shell go env GOPATH)/bin/buf" && \
  	chmod +x "$(shell go env GOPATH)/bin/buf"

	echo "Install linter"
	curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(shell go env GOPATH)/bin v1.42.0

generate:
	@echo "Generate proto"
	buf mod update
	buf generate

lint:
	@echo "Run linter"
	# Lint proto
	buf lint
	# Lint golang
	golangci-lint run

test:
	@echo "Run unit tests"
	go test --race -v ./... -coverprofile coverage.txt -covermode atomic
	@echo "Code coverage"
	go tool cover -func coverage.txt

build:
	@echo "Build app binary"
	go build -o out/server

build_docker:
	@echo "Build app docker container"
	docker build . -t iakrevetkho/dots/server

run_docker:
	@echo "Run app docker container"
	docker run -p 8080:8080 -p 8090:8090 iakrevetkho/dots/server -t dots_server

build_and_run_docker:
	make build_docker
	make run_docker

run:
	@echo "Run app"
	go run .