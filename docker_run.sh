#!/usr/bin/env bash

# activate license
optimizer-studio-license --activate=${OPTIMIZER_LICENSE_KEY}

# run the experiment
optimizer-studio --knobs ${OPTIMIZER_HOME}/knobs.yaml --max-minutes=5 --workload-timeout=1m

# deactivate license
optimizer-studio-license --deactivate