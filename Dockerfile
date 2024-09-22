FROM node:16 as builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:1.21.6-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*

COPY --from=builder /app/dist .
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/csp_maps.conf /etc/nginx/includes/csp_maps.conf
COPY ./nginx/csp_directives.conf /etc/nginx/includes/csp_directives.conf

RUN chmod -R 755 /usr/share/nginx/html
CMD nginx -g 'daemon off;' || (echo "Nginx failed to start. Error log:" && cat /var/log/nginx/error.log)