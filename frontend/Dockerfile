FROM node:19.0.0-alpine as build
WORKDIR /usr/local/app
COPY . .
RUN npm ci --silent
# Have a .dockerignore file ignoring node_modules and build
COPY . ./
RUN npm run build
# Production
FROM nginx:stable-alpine
COPY --from=build /usr/local/app/build /usr/share/nginx/html
RUN chmod -R 755 /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]