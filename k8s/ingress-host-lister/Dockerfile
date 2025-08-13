FROM docker.io/golang:1.25

WORKDIR /app
COPY go.mod go.sum main.go ./
RUN go mod tidy \
    && go build -ldflags="-s -w" -v -o main . \
    && chmod +x main

ENTRYPOINT ["./main"]
