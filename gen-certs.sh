#!/usr/bin/env bash

openssl req -x509 \
            -sha256 -days 356 \
            -nodes \
            -newkey rsa:2048 \
            -subj "/CN=kafka-server" \
            -keyout server.key -out server.crt

openssl req -x509 \
            -sha256 -days 356 \
            -nodes \
            -newkey rsa:2048 \
            -subj "/CN=kafka-client" \
            -keyout client.key -out client.crt

openssl x509 -in server.crt -out server.pem -outform PEM
openssl x509 -in client.crt -out client.pem -outform PEM

cat server.crt server.key > server.pem

chmod 644 *.crt *.key
