# build
FROM node:16-alpine3.16 as builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# release
FROM nginx:latest
WORKDIR /app
COPY --from=builder /usr/src/app/dist/ /usr/share/nginx/html
EXPOSE 80

