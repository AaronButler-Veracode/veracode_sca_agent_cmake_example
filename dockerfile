# Use an official base image (e.g., Ubuntu)
FROM ubuntu:22.04

# Set environment variables for the desired CMake version
ENV CMAKE_VERSION=4.0.1

# Install necessary tools to download and build (wget, tar, build-essential)
RUN apt-get update && apt-get install -y gcc \ 
	git \ 
	wget \ 
	tar \ 
	build-essential \
	coreutils \ 
	software-properties-common \
	pkgconf \
	qt6-base-dev \
	qt6-tools-dev \
	qt6-tools-dev-tools \
	libqt6svg6-dev \
	qt6-l10n-tools \
	libgl-dev \
	libboost-dev \
	libssl-dev \
	libprotobuf-dev \
	protobuf-compiler \
	libprotoc-dev \
	libcap-dev \
	libxi-dev \
	libasound2-dev \
	libogg-dev \
	libsndfile1-dev \
	libopus-dev \
	libspeechd-dev \
	libavahi-compat-libdnssd-dev \
	libxcb-xinerama0 \
	libzeroc-ice-dev \
	libpoco-dev \
	g++-multilib

# Install Veracode SCA Agent
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DF7DD7A50B746DD4
RUN add-apt-repository -y "deb https://sca-downloads.veracode.com/ubuntu stable/"
RUN apt-get update
RUN apt-get install srcclr

# Download, extract, and install CMake
RUN wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz -O /tmp/cmake.tar.gz \
    && tar -zxf /tmp/cmake.tar.gz -C /opt \
    && rm /tmp/cmake.tar.gz

# Add the CMake binary directory to the PATH
ENV CMAKE_ROOT="/opt/cmake-${CMAKE_VERSION}-linux-x86_64/"
ENV PATH="${PATH}:${CMAKE_ROOT}bin"

# Verify the installation
RUN cmake --version

# Clone test repo
# RUN mkdir -p /home/testing/cpp-starter-project-cmake
# RUN git clone https://github.com/josephgarnier/cpp-starter-project-cmake.git --recursive /home/testing/cpp-starter-project-cmake
# RUN rm -rfvI /home/testing/cpp-starter-project-cmake/src/*
# RUN rm -rfvI /home/testing/cpp-starter-project-cmake/include/*
# RUN rm -rfvI /home/testing/cpp-starter-project-cmake/tests/*

RUN mkdir -p /home/testing/muble

RUN git clone --depth 1 --recursive https://github.com/mumble-voip/mumble.git --recursive /home/testing/muble

RUN cd /home/testing/muble

RUN git  -C ./home/testing/muble submodule update --init --recursive

RUN cmake -S /home/testing/muble -B /home/testing/muble/build -Denable-postgresql=OFF -Dclient=OFF

#RUN srcclr scan /home/testing/muble/build
