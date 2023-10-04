# build
FROM golang:1.19 as builder
WORKDIR /app/src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o backend ./cmd/api/

# release
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/src/backend ./backend
EXPOSE 8081
ENTRYPOINT ["./backend"]
