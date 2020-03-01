#!/usr/bin/env bash

# locate the Last opitmizer execution results JSON report
# to be used to extract meaningful summary data to pipeline
# such as improvement %
ls -1 ${SOURCE_FOLDER}/*.json |tail -1

