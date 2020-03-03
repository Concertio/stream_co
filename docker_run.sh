#!/usr/bin/env bash

# activate license
optimizer-studio-license --activate=${OPTIMIZER_LICENSE_KEY}

# run the experiment
optimizer-studio --knobs ${OPTIMIZER_HOME:-/opt/concertio-optimizer/studio}/knobs.yaml --max-minutes=${OPTIMIZER_MAX_MINUTES:-5} --workload-timeout=1m --settings-script=/tmp/settings.sh

# write best results to flags file for commit
source /tmp/settings.sh valarray
echo ${KNOB_VALUES_TUNED[*]} > flags.make

# deactivate license
optimizer-studio-license --deactivate