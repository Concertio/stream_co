#!/usr/bin/env bash

# run optimizer for stream.c compilation flag mining
# if license was not provided in Dockerfile, can pass it here at runtime
docker run --rm -ti -e OPTIMIZER_LICENSE_KEY --mount type=bind,source="$(pwd)",target=/opt/concertio-optimizer/studio/src \
 optimize_stream --max-minutes=5 --workload-timeout=1m
