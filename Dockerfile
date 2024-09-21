FROM node:16

# Install Nginx
RUN apt-get update && apt-get install -y nginx

WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Remove default Nginx config
RUN rm /etc/nginx/sites-enabled/default

# Copy custom Nginx configs
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/locations.conf /etc/nginx/locations.conf
COPY nginx/custom_headers.conf /etc/nginx/custom_headers.conf
COPY nginx/header_maps.conf /etc/nginx/header_maps.conf

# Expose port 80
EXPOSE 80

# Start Nginx and the Node.js app
CMD service nginx start && node src/index.js