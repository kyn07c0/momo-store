# build
FROM node:16-alpine3.18 as builder
ARG VERSION=${VERSION}
ARG VUE_APP_API_URL=kyn07c0.ru
ARG NODE_ENV=dev
WORKDIR /usr/src/app
COPY package*.json ./
COPY . .
RUN npm install
RUN npm run build

# release
FROM nginx:latest
ARG VERSION=${VERSION}
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html
COPY .nginx/default.conf /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80

