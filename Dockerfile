FROM golang:1.26.5 AS builder

WORKDIR /app

COPY go.mod .
COPY *.go .

RUN go mod tidy

RUN CGO_ENABLED=0 go build -o auth-service .

FROM golang:1.26.5-alpine

WORKDIR /app

COPY --from=builder /app/auth-service .

EXPOSE 8001

CMD ["./auth-service"]
