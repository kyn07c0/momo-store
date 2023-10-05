FROM golang:1.20-alpine as builder
WORKDIR /app
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /main ./cmd/api

FROM alpine:latest
WORKDIR /root
RUN apk --no-cache add curl
COPY --from=builder /app/api .
EXPOSE 8081
CMD ["/bin/main"]
