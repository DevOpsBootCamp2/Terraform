#!/bin/sh

ed -s /home/ubuntu/.bash_profile  <<EOE
$
a
export DRONE_SECRET=BootCampDroneTestSecret 
export DRONE_GITHUB_CLIENT=6538a0a85ad3851990d3
export DRONE_GITHUB_SECRET=ced87a6dc135edb22952095b72be36453dfc5461

echo END of bash_profile
.
w
q
EOE