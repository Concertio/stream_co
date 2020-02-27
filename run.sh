#!/usr/bin/env bash

# run optimizer for stream.c compilation flag mining
docker run --rm -ti --mount type=bind,source="$(pwd)",target=/opt/concertio-optimizer/studio/src optimize_stream --max-minutes=5 --workload-timeout=1m
