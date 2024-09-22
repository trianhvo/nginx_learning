# Simple Node with Express Server

[![Build Status](https://travis-ci.org/rwieruch/node-express-server.svg?branch=master)](https://travis-ci.org/rwieruch/node-express-server) [![Slack](https://slack-the-road-to-learn-react.wieruch.com/badge.svg)](https://slack-the-road-to-learn-react.wieruch.com/) [![Greenkeeper badge](https://badges.greenkeeper.io/rwieruch/node-express-server.svg)](https://greenkeeper.io/)

An easy way to get started with a Express server with Node.js.

## Features

* Express

## Requirements

* [node & npm](https://nodejs.org/en/)
* [git](https://www.robinwieruch.de/git-essential-commands/)

## Installation

* `git clone git@github.com:rwieruch/node-express-server.git`
* `cd node-express-server`
* `npm install`
* `npm start`


## Server
# Stop and remove the old container (if it's running)
sudo docker stop my-express-container
sudo docker rm my-express-container

# Build the new Docker image
sudo docker build -t my-express-app .

# Run the new container
sudo docker run -p 80:80 -d --name my-express-container my-express-app

# Check deploy status
sudo docker ps -a

# Check docker logs
sudo docker logs dockerID

# Check files in docker image
sudo docker exec -it my-express-container /bin/sh