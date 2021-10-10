# dots server
Server for Dots game

## Install dependencies

```sh
make install
```

## Generate protobuf & docs

```sh
make generate
```

## Presequinces

`dots_server` requires folder for log files.
To create it run:
```sh
sudo mkdir /var/log/dots
sudo chown $USER /var/log/dots
```

## Build

### Docker

To build docker image use:
```sh
make build_docker
```

## Run

### Binary

To run server use:
```sh
make run
```

### Docker

To run server in docker use:
```sh
make run_docker
```

Or use prebuilded version:
```sh
docker run -d -p 8080:8080 -p 8090:8090 --name dots_server ghcr.io/iakrevetkho/dots/server:<version>
```

## Test

### Unit test

For unit tests use:
```sh
make test
```

### Lint

For lint use:
```sh
make lint
```

### gRPC

For testing gRPC API use [Kreya](https://kreya.app/)

Folder `kreya` contains Kreya project for working with the project.

Also `archaeopteryx` is compatible with [gRPC reflection](https://github.com/grpc/grpc/blob/master/doc/server-reflection.md)