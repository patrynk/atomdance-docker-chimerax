# Some configuration options adapted from https://github.com/jozo/docker-pyqt5/blob/master/default/Dockerfile
FROM ubuntu:22.04

# Add analysis user
RUN adduser --quiet --disabled-password atomuser && usermod -a -G audio atomuser

# Set environment variables
ENV LIBGL_ALWAYS_INDIRECT=1
ENV XDG_RUNTIME_DIR='/tmp/runtime-atomuser'
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3-pyqt5 \
    build-essential \
    g++\
    gfortran \
    m4 \
    wget \
    curl \
    zlib1g \
    zlib1g-dev

# cpptraj installation workflow, ver. 6.20.5
COPY ./lib/cpptraj /cpptraj/
WORKDIR /cpptraj/
RUN ./configure gnu --buildlibs
RUN make install

WORKDIR /

COPY ./lib/ATOMDANCE-comparative-protein-dynamics /atomdance/

RUN echo "#! /usr/bin/env bash" >> /usr/bin/start
RUN echo "python3 /atomdance/ATOMDANCE.py" >> /usr/bin/start
RUN chmod +x /usr/bin/start