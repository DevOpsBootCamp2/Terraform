#!/bin/sh

mkdir /home/ubuntu/drone-cli
cd /home/ubuntu/drone-cli

curl http://downloads.drone.io/release/linux/amd64/drone.tar.gz  | tar zx

sudo install -t /usr/local/bin drone
