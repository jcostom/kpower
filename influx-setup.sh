#!/usr/bin/env bash

INFLUXDB_BUCKET="plugs"
INFLUXDB_ORG="plugland"
INFLUXDB_USERNAME="my-influx-username"
INFLUXDB_PASSWORD="my-influx-password"

# grab latest image
docker pull influxdb:2.5

# setup volumes
docker volume create influx-data
docker volume create influx-config

# create the temp container
docker run --name influxdb -d \
  -p 8086:8086 \
  --volume influx-data:/var/lib/influxdb2 \
  --volume influx-config:/etc/influxdb2 \
  influxdb:2.5
# wait until the database server is ready
until docker exec influxdb influx ping
do
  echo "Retrying..."
  sleep 5
done
# configure influxdb
docker exec influxdb influx setup \
  --bucket $INFLUXDB_BUCKET \
  --org $INFLUXDB_ORG \
  --password $INFLUXDB_PASSWORD \
  --username $INFLUXDB_USERNAME \
  --force
# get the token
docker exec influxdb influx auth list | \
awk -v username=$INFLUXDB_USERNAME '$5 ~ username {print $4 " "}'

# cleanup
docker stop influxdb
docker rm influxdb