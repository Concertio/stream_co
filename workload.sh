
### GET THE KNOBS

# source studio bash functions to extract flag knobs (k->val array)
# the env variable OPTIMIZER_HOME and SOURCE_FOLDER are expected to exist in the 'optimize_stream' container

. ${OPTIMIZER_HOME}/studio-functions.bash
cd ${SOURCE_FOLDER}

# call memory knobs function to get current knobs options as array
get_memory_knobs > /dev/null


### RUN THE COMPILATION WITH THE FLAG KNOBS

BINARY_FILE=/tmp/stream

CMD="gcc ${KNOB_VALUES[*]} stream.c -o ${BINARY_FILE}"
$CMD
res=$?

if [[ ! -f ./stream ]]; then
	echo "something went wrong with gcc stream.c compilation. aborting"
	echo "Error recieved: $res"
	echo "command was: $CMD"
	echo invalid > /tmp/t_metric
	exit 1
fi

### RUN THE ARTIFACT BINARY TO MEASURE PERFORMANCE

sample=$( ${BINARY_FILE} | grep Triad | awk '{print $2}' )

### CLEANUP

rm ${BINARY_FILE}

### REPORT RESULT METRIC TO OPTIMIZER

echo -n $sample > /tmp/t_metric
exit 0