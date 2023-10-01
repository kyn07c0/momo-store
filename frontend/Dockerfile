# build
FROM node:16-alpine3.18 as builder
ARG VUE_APP_API_URL=http://kyn07c0.ru
ARG NODE_ENV=production
WORKDIR /usr/src/app
COPY package*.json ./
COPY . .
RUN npm install
RUN npm run build

# release
FROM nginx:latest
WORKDIR /app
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html
COPY .nginx/default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80

