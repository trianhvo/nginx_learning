FROM node:16 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/dist .
COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY ./nginx/csp_maps.conf /etc/nginx/includes/csp_maps.conf
COPY ./nginx/csp_directives.conf /etc/nginx/includes/csp_directives.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]