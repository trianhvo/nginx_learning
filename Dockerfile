# Build stage
FROM node:18-alpine as builder
WORKDIR /app

# Set up npm registry
ARG NPM_REGISTRY="https://registry.npmjs.org"
RUN npm config set registry $NPM_REGISTRY
RUN npm config set color false

# Copy application files
COPY . .

# Install dependencies and build
RUN npm install
RUN npm run test
RUN npm run build

# Run stage
FROM nginx:1.21.6-alpine
WORKDIR /usr/share/nginx/html

# Remove default nginx static assets
RUN rm -rf ./*

# Copy the build output to Nginx html folder
COPY dist/* /usr/share/nginx/html/

RUN mkdir -p /etc/nginx/includes

# Copy nginx configuration files
COPY nginx/default.conf /etc/nginx/nginx.conf
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY nginx/csp_maps.conf /etc/nginx/includes/csp_maps.conf
COPY nginx/csp_directives.conf /etc/nginx/includes/csp_directives.conf

# Expose port 80
EXPOSE 80

# Start nginx
ENTRYPOINT ["nginx", "-g", "daemon off;"]
