#!/bin/sh

mkdir /home/ubuntu/drone-cli
cd /home/ubuntu/drone-cli

curl http://downloads.drone.io/release/linux/amd64/drone.tar.gz  | tar zx

sudo install -t /usr/local/bin drone
cd
export DRONE_SERVER=http://localhost

export DRONE_TOKEN=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZXh0IjoiTmlyYWpTYXBhcmlhIiwidHlwZSI6InVzZXIifQ.OeXbCXJCYnETJHVqA7LVvcSjiverT3Vfx7-gRhSVQDs

drone secret add -skip-verify=true DevOpsBootCamp2/devOpsCampAPI HUB_PASS Cap2016#
