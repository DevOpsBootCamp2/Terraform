#!/bin/bash

usermod -aG docker ubuntu
curl -sSL https://get.docker.com/ | sh
curl -L https://github.com/docker/compose/releases/download/1.12.0-rc2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

chown ubuntu:ubuntu /home/ubuntu/docker-compose.yml
su - ubuntu
export DRONE_SECRET=BootCampDroneTestSecret
export DRONE_GITHUB_CLIENT=6538a0a85ad3851990d3
export DRONE_GITHUB_SECRET=ced87a6dc135edb22952095b72be36453dfc5461
docker-compose up -d
