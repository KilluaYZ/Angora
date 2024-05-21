FROM ubuntu:16.04

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y git build-essential wget zlib1g-dev golang-go python-pip python-dev build-essential cmake && \
    apt-get clean

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PIN_ROOT=/pin-3.20-98437-gf02b61307-gcc-linux \
    GOPATH=/go \
    PATH=/clang+llvm/bin:/usr/local/cargo/bin:/angora/bin/:/go/bin:$PATH \
    LD_LIBRARY_PATH=/clang+llvm/lib:$LD_LIBRARY_PATH

RUN echo -e "export RUSTUP_HOME=/usr/local/rustup \n" >> /root/.bashrc
RUN echo -e "export CARGO_HOME=/usr/local/cargo \n" >> /root/.bashrc
RUN echo -e "export PIN_ROOT=/pin-3.20-98437-gf02b61307-gcc-linux \n" >> /root/.bashrc
RUN echo -e "export GOPATH=/go \n" >> /root/.bashrc
RUN echo -e "export PATH=/clang+llvm/bin:/usr/local/cargo/bin:/angora/bin/:/go/bin:$PATH \n" >> /root/.bashrc
RUN echo -e "export LD_LIBRARY_PATH=/clang+llvm/lib:$LD_LIBRARY_PATH \n" >> /root/.bashrc

RUN mkdir -p angora
COPY . angora
WORKDIR angora

RUN ./build/install_rust.sh 
RUN rustup install 1.70.0 && rustup default 1.70.0 && rustup override set 1.70.0
RUN PREFIX=/ ./build/install_llvm.sh
RUN ./build/install_tools.sh
RUN ./build/build.sh
RUN ./build/install_pin_mode.sh

VOLUME ["/data"]
WORKDIR /data
ENTRYPOINT [ "/opt/env.init" ]
