FROM us.gcr.io/concertio-devel/optimizer-studio-buster:2.7.0-1 as base
LABEL author="Tomer Paz. Concertio 2020"

# install build and other tools required for compile flag testing
RUN apt-get update && apt-get install -q -y gcc bc curl \
    bash-completion cmake make openssh-client git

FROM base
# create src folder under optimizer-studio main folder
# to be used for mounting git repo from local OS filesystem
# and run the builds. prepare env for build tools

ENV OPTIMIZER_HOME=/opt/concertio-optimizer/studio
ENV SOURCE_FOLDER=${OPTIMIZER_HOME}/src

# since optimizer checks who owns knobs.yaml and this container is root...:
COPY knobs.yaml ${OPTIMIZER_HOME}/

# to be used for mounted source code folder
RUN mkdir -p ${SOURCE_FOLDER} && \
    chmod 400 ${OPTIMIZER_HOME}/knobs.yaml

WORKDIR ${SOURCE_FOLDER}

ENTRYPOINT [ "optimizer-studio", "--knobs=../knobs.yaml" ]
