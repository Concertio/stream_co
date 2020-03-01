#!/usr/bin/env bash

# locate the Last opitmizer execution results JSON report
# to be used to extract meaningful summary data to pipeline
# such as improvement %
ls -ltr ~/.concertio/report_*.json |tail -1 | awk '{ print $9 }'

