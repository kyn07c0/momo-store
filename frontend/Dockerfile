# build
FROM node:16-alpine3.18 as builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# release
FROM nginx:stable
RUN mkdir /app
COPY --from=builder /usr/src/app/dist /app
COPY nginx-momo.conf /etc/nginx/conf.d/nginx-momo.conf
EXPOSE 80
CMD nginx -g "daemon off;"
