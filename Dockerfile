# Builder Stage
FROM golang:1.20 AS builder
WORKDIR /app
RUN apt-get update && apt-get install -y libzmq3-dev
COPY . .
RUN go build -o gotrain

# Runtime Stage
FROM debian:bookworm-slim
WORKDIR /app
RUN apt-get update && apt-get install -y libzmq3-dev
COPY --from=builder /app/gotrain /app/gotrain
RUN chmod +x /app/gotrain
CMD ["/app/gotrain", "archiver"]