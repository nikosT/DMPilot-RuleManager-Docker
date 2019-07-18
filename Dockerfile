
## modify the configuration.py file which is at the same dir with this Dockerfile
## docker build -t "rulemanager:1" .
## docker run -dit --name rule_manager rulemanager:1 /bin/bash
## docker exec -it rule_manager /bin/bash

FROM ubuntu:18.04
MAINTAINER triantafyl@noa.gr

# install global dependencies
RUN apt-get update
RUN apt install -y git make gcc nano python3 python3-pip
RUN pip3 install -U numpy
RUN pip3 install -U obspy
RUN pip3 install -U jsonschema
RUN pip3 install -U python-irodsclient
RUN pip3 install -U bson
RUN pip3 install -U pymongo

# get the code
RUN git clone https://github.com/KNMI/DMPilot-RuleManager.git

# install local dependencies
WORKDIR /DMPilot-RuleManager/lib/dataselect-3.21
RUN make
WORKDIR /DMPilot-RuleManager/lib/libmseed-2.19.6
RUN make clean
RUN make
WORKDIR /DMPilot-RuleManager/lib/libmseed-2.19.6/example
RUN make
WORKDIR /DMPilot-RuleManager/lib/msi-3.8
RUN make

# copy dependencies to the bin folder of the Rule Manager
WORKDIR /DMPilot-RuleManager
RUN mkdir -p ./bin
RUN cp lib/dataselect-3.21/dataselect ./bin/
RUN cp lib/libmseed-2.19.6/example/msrepack ./bin/
RUN cp lib/msi-3.8/msi ./bin/

# add binaries to path
ENV PATH="/DMPilot-RuleManager/bin:${PATH}"

# copy configuration file
COPY ./configuration.py .


