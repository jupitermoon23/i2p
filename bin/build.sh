#!/usr/bin/env bash

docker build --no-cache -t divax/i2p:latest .
docker volume create i2pd-build
docker run -d --mount type=volume,src=i2pd-build,dst=/home/i2pd/ --name i2pd-build divax/i2p:latest

# update certs
rm -R certificates
cp -r -f /var/lib/docker/volumes/i2pd-build/_data/data/certificates ./certificates
chown -R --reference ./ certificates

# update changelog & license
cp -r -f /var/lib/docker/volumes/i2pd-build/_data/ChangeLog ./ChangeLog-i2pd
cp -r -f /var/lib/docker/volumes/i2pd-build/_data/LICENSE ./LICENSE-i2pd

# clean up
docker stop i2pd-build
docker rm i2pd-build
docker volume rm i2pd-build
