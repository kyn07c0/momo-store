FROM golang:1.17-alpine3.16 AS builder
WORKDIR /app
COPY go.mod go.sum ./ 
RUN  go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main ./cmd/api

FROM alpine:3.17.0
WORKDIR /root/
COPY --from=builder /app/main .
EXPOSE 8081
ENTRYPOINT ["./main"]
