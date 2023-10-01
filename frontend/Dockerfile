# build
FROM node:16-alpine3.18 as builder
ARG VUE_APP_API_URL
ARG VUE_APP_VERSION
WORKDIR /usr/src/app
COPY package*.json ./
COPY . .
RUN npm install
RUN npm run build

# release
FROM nginx:latest
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html
COPY .nginx/default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80

