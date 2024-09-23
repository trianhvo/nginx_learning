# Build stage
FROM node:18-alpine as builder
WORKDIR /app

# Set up npm registry (using a public registry for this example)
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

# Copy static assets from builder stage
COPY --from=builder /app/dist .

RUN mkdir -p /etc/nginx/includes
# Copy nginx configuration
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./nginx/nginx.conf /etc/nginx/conf.d/nginx.conf
COPY ./nginx/csp_maps.conf /etc/nginx/includes/csp_maps.conf
COPY ./nginx/csp_directives.conf /etc/nginx/includes/csp_directives.conf


# Start nginx
ENTRYPOINT ["nginx", "-g", "daemon off;"]