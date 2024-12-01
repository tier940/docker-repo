FROM golang:1.23 AS builder

WORKDIR /app
COPY . .
RUN go mod init ingresshostlister && go mod tidy
RUN go build -o main .

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/main .
ENTRYPOINT ["./main"]
