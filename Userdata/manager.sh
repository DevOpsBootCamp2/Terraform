#!/bin/bash

usermod -aG docker ubuntu
curl -sSL https://get.docker.com/ | sh
