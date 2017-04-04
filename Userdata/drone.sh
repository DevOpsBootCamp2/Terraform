#!/bin/bash

usermod -aG docker ubuntu
curl -sSL https://get.docker.com/ | sh
curl -L https://github.com/docker/compose/releases/download/1.12.0-rc2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
ed -s /home/ubuntu/docker-compose.yml <<EOE
a
version: '2'

services:
  drone-server:
    image: drone/drone:0.5
    ports:
      - 80:8000
    volumes:
      - ./drone:/var/lib/drone/
    restart: always
    environment:
      - DRONE_OPEN=true
      - DRONE_GITHUB=true
      - DRONE_GITHUB_CLIENT=${DRONE_GITHUB_CLIENT}
      - DRONE_GITHUB_SECRET=${DRONE_GITHUB_SECRET}
      - DRONE_SECRET=${DRONE_SECRET}
      - DRONE_ADMIN=NirajSaparia,mgopaul2

  drone-agent:
    image: drone/drone:0.5
    command: agent
    restart: always
    depends_on: [ drone-server ]
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      - DRONE_SERVER=ws://drone-server:8000/ws/broker
      - DRONE_SECRET=${DRONE_SECRET}

.
w
q
EOE
chown ubuntu:ubuntu /home/ubuntu/docker-compose.yml
su - ubuntu
export DRONE_SECRET=BootCampDroneTestSecret
export DRONE_GITHUB_CLIENT=6538a0a85ad3851990d3
export DRONE_GITHUB_SECRET=ced87a6dc135edb22952095b72be36453dfc5461
docker-compose up -d
