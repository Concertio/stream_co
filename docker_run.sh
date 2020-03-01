#!/usr/bin/env bash

# activate license
optimizer-studio-license --activate=${OPTIMIZER_LICENSE_KEY}

# run the experiment
optimizer-studio --settings ${SOURCE_FOLDER}/settings.yaml --knobs ${OPTIMIZER_HOME:-/opt/concertio-optimizer/studio}/knobs.yaml --max-minutes=${OPTIMIZER_MAX_MINUTES:-5} --workload-timeout=1m

# deactivate license
optimizer-studio-license --deactivate
