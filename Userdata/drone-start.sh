#!/bin/sh

. ~/.bash_profile
service docker status
docker ps
docker-compose up -d
