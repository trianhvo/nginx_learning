#!/bin/bash

# Stop and remove the existing container
sudo docker stop my-express-container || true
sudo docker rm my-express-container || true

# Build the new image
sudo docker build -t my-express-app .

# Run the new container
sudo docker run -p 80:80 -d --name my-express-container my-express-app

echo "Waiting 5 seconds before checking container status..."
sleep 5

# Check the status
sudo docker ps -a

# Check the logs for any errors
sudo docker logs my-express-container