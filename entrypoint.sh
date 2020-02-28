#!/usr/bin/env bash

# activate license
optimizer-studio-license --activate=${OPTIMIZER_LICENSE_KEY}

# run the experiment
optimizer-studio --knobs ../knobs.yaml

# deactivate license
optimizer-studio-license --deactivate