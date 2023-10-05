FROM golang:1.20-alpine as builder
WORKDIR /build
COPY . . 
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o /app ./cmd/api

FROM alpine:latest
COPY --from=builder app /bin/app
EXPOSE 8081
CMD ["/bin/app"]
