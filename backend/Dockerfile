FROM golang:1.17-alpine3.16 AS builder
WORKDIR /app
COPY go.mod go.sum /app/
RUN  go mod download
COPY . /app
RUN go build -o /app /app/api

FROM alpine:3.16
WORKDIR /app
COPY --from=builder /app/api /app/api
EXPOSE 8081 
ENTRYPOINT ["/app/api"]
