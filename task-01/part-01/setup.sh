#!/bin/bash -xe
sudo apt-get update -y
sudo apt-get install -y docker-compose
sudo apt install git -y

docker run -d   \
    --name postgres-test   \
    -p 5432:5432   \
    -e POSTGRES_USER=postgres   \
    -e POSTGRES_PASSWORD=pass   \
    -e POSTGRES_DB=demo   \
       postgres
# sleep for 1 minute
sleep 60

docker run -d   \
    -p 80:8000   \
    --name soul-animal   \
    -e DATABASE_URL=postgresql://postgres:pass@172.17.0.1/demo   \
    n0x41yeem/soul-animal:latest