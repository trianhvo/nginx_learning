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
COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY ./nginx/csp_maps.conf /etc/nginx/includes/csp_maps.conf
COPY ./nginx/csp_directives.conf /etc/nginx/includes/csp_directives.conf
ENTRYPOINT ["nginx", "-g", "daemon off;"]