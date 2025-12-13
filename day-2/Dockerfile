# Optimized multi-stage and caching aware Dockerfile 
FROM golang:1.25 AS builder

WORKDIR /app

COPY go.mod go.sum .
RUN go mod download

COPY . . 

RUN --mount=type=cache,target=/root/.cache/go-build \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \ 
    go build -o main -ldflags="-s -w" -trimpath ./...

FROM alpine:latest AS runner

WORKDIR /app

RUN addgroup -S apprunner && \
  adduser appuser -S -D -H -G apprunner

USER appuser

COPY --from=builder --chown=appuser:apprunner /app/main .

EXPOSE 8000

CMD ["./main"]