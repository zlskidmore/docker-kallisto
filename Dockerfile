# work from latest LTS ubuntu release
FROM ubuntu:18.04

# set the environment variables
ENV kallisto_version 0.45.1

# run update and install necessary tools
RUN apt-get update -y && apt-get install -y \
    build-essential \
    cmake \
    zlib1g-dev \
    libhdf5-dev \
    libnss-sss \
    curl \
    autoconf

# install kallisto
RUN mkdir -p /usr/bin/kallisto \
    && curl -SL https://github.com/pachterlab/kallisto/archive/v0.44.0.tar.gz \
    | tar -zxvC /usr/bin/kallisto

RUN mkdir -p /usr/bin/kallisto/kallisto-${kallisto_version}/build
RUN cd /usr/bin/kallisto/kallisto-${kallisto_version}/build && cmake ..
RUN cd /usr/bin/kallisto/kallisto-${kallisto_version}/ext/htslib && autoreconf
RUN cd /usr/bin/kallisto/kallisto-${kallisto_version}/build && make
RUN cd /usr/bin/kallisto/kallisto-${kallisto_version}/build && make install
