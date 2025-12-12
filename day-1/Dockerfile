FROM golang:1.25-alpine AS builder

WORKDIR /usr/src/app
COPY main.go .

RUN go build -o main main.go

FROM alpine:latest AS runner

WORKDIR /usr/src/app
RUN addgroup -S apprunner && \
  adduser appuser -S -D -H -G apprunner

USER appuser
COPY --from=builder --chown=appuser:apprunner /usr/src/app/main .

EXPOSE 8000

CMD ["./main"]