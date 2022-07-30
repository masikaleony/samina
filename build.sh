#!/bin/bash
version="1.1.0"
image="cpuminer-rx2"
docker build . --tag docker.io/cnyui/$image:$version
docker tag docker.io/cnyui/$image:$version docker.io/cnyui/$image:latest
docker tag docker.io/cnyui/$image:$version ghcr.io/cnyui/$image:$version
docker tag docker.io/cnyui/$image:$version ghcr.io/cnyui/$image:latest
docker tag docker.io/cnyui/$image:$version quay.io/cnyui/$image:$version
docker tag docker.io/cnyui/$image:$version quay.io/cniweb/$image:latest
docker push docker.io/cnyui/$image:$version
docker push docker.io/cnyui$image:latest
docker push ghcr.io/cnyui/$image:$version
docker push ghcr.io/cnyui/$image:latest
docker push quay.io/cnyui/$image:$version
docker push quay.io/cnyui/$image:latest
