FROM golang:1.23 AS builder

WORKDIR /app
COPY go.mod .
COPY go.sum .
RUN go mod tidy
COPY . .
RUN go build -o main .

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/main .
RUN chmod +x main
ENTRYPOINT ["./main"]
