#!/bin/bash
set -e


docker build --tag matlockx/openvpn .
docker push matlockx/openvpn
