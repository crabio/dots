# Build stage
FROM golang AS build-env
ADD . /src
ENV CGO_ENABLED=0
RUN apt-get update -y && \
    # Build binary
    cd /src && \
    go build -o /app/main && \
    # Get gRPC health probe
    wget https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/v0.4.5/grpc_health_probe-linux-amd64 -O /app/grpc_health_probe && \
    chmod +x /app/grpc_health_probe

# Production stage
FROM alpine:3
COPY --from=build-env /app /

# Create folder for logs
RUN mkdir /var/log/archaeropteryx

HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD /grpc_health_probe -addr 0.0.0.0:8080 || exit 1
ENTRYPOINT ["/main"]
