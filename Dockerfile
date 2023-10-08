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
    python3-pyqt5=5.15.6+dfsg-1ubuntu3 \
    build-essential=12.9ubuntu3 \
    g++=4:11.2.0-1ubuntu1 \
    gfortran=4:11.2.0-1ubuntu1 \
    m4=1.4.18-5ubuntu2 \
    wget=1.21.2-2ubuntu1 \
    curl=7.81.0-1ubuntu1.13 \
    zlib1g=1:1.2.11.dfsg-2ubuntu9.2 \
    zlib1g-dev=1:1.2.11.dfsg-2ubuntu9.2

# cpptraj installation workflow, ver. 6.20.5
COPY ./lib/cpptraj /cpptraj/
WORKDIR /cpptraj/
RUN ./configure gnu --buildlibs
RUN make install

WORKDIR /

COPY ./bin/* /atomdance/

RUN echo "#! /usr/bin/env bash" >> /usr/bin/start
RUN echo "python3 /atomdance/ATOMDANCE.py" >> /usr/bin/start
RUN chmod +x /usr/bin/start