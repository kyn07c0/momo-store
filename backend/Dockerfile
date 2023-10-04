FROM golang:1.19-alpine
WORKDIR /usr/src/app
COPY . .
EXPOSE 8081
ENTRYPOINT ["go", "run", "./cmd/api"]
