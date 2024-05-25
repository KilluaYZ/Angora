#!/bin/bash

set -euxo pipefail

#wllvm and gllvm
pip install --upgrade pip==9.0.3
# python3 -m venv .venv
# echo  "source /Angora/.venv/bin/activate " >> /root/.bashrc
# source /root/.bashrc
pip install wllvm
mkdir ${HOME}/go
# go get github.com/SRI-CSL/gllvm/cmd/...
go install github.com/SRI-CSL/gllvm/cmd/...@latest

