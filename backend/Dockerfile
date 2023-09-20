# build
FROM golang:1.19 as builder
WORKDIR /usr/src/app
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o ./momo-backend

# release
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/run/momo-backend ./momo-backend
EXPOSE 8090
ENTRYPOINT ["./momo-backend"]
