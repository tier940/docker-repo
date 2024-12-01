FROM golang:1.23 AS builder

WORKDIR /app
COPY go.mod .
COPY go.sum .
RUN go mod tidy
COPY . .
RUN go build -v -o main .

FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/main .
RUN chmod +x main

RUN apk add --no-cache ca-certificates
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

ENTRYPOINT ["./main"]
