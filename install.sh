#!/bin/bash

####
# Change these if you want to
####
DEV_BASE=~/
DEV_DIR=Dev
GO_DIR=Go

####
# Don't change anything from this point on
####

# Dev Root is where all of our project source code goes
DEV_ROOT=${DEV_BASE}${DEV_DIR}/src
mkdir -p ${DEV_ROOT}

# Local Src is for external dependencies like the go source code or nodejs
# source code
LOCAL_SRC=${DEV_BASE}${DEV_DIR}/x
mkdir -p ${LOCAL_SRC}

ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	OS=linux
elif [[ "$OSTYPE" == "darwin"* ]]; then
	OS=osx
else
	echo -e "${COL_RED}This script only works on Linux and OSX $COL_RESET"
	exit 1
fi

if [[ ${OS} == "linux" ]]; then
	source tools_linux.sh
elif [[ ${OS} == "osx" ]]; then
	source tools_osx.sh
fi

####
# Go
####
echo -e "${COL_GREEN}Go $COL_RESET"

REPO_SRC=https://go.googlesource.com/go
REPO=${LOCAL_SRC}/go1.4.2
GOVER=1.4.2
if [ ! -d ${REPO} ]
then
	cd ${LOCAL_SRC}
	git clone ${REPO_SRC} ${REPO}
	cd ${REPO}/src
	git checkout go${GOVER}
	./all.bash
else
	cd ${REPO}/src
	git fetch
	git pull
	git checkout go${GOVER}
	./all.bash
fi

export GOROOT_BOOTSTRAP=${REPO}

REPO=${LOCAL_SRC}/go
GOVER=1.5
if [ ! -d ${REPO} ]
then
	cd ${LOCAL_SRC}
	git clone ${REPO_SRC}
	cd ${REPO}/src
	git checkout go${GOVER}
	./all.bash
else
	cd ${REPO}/src
	git fetch
	git pull
	git checkout go${GOVER}
	./all.bash
fi

export GOROOT=${LOCAL_SRC}/go
export GOPATH=${DEV_BASE}${DEV_DIR}
export PATH=${PATH}:${GOROOT}/bin
export PATH=${PATH}:${GOPATH}/bin
GO_MICROCOSM_CC=${GOPATH}/src/github.com/microcosm-cc
mkdir -p $GO_MICROCOSM_CC

go get -u golang.org/x/tools/cmd/cover
go get -u golang.org/x/tools/cmd/godoc
go get -u golang.org/x/tools/cmd/goimports
go get -u golang.org/x/tools/cmd/vet
go get -u github.com/golang/lint/golint

####
# Final instructions
####
echo -e "${COL_RED}If this was a first install: "
echo -e "1) Configure your ~/.bashrc file and include:"
echo -e "    export GOPATH=${GOPATH}"
echo -e "    export GOROOT=${GOROOT}"
echo -e "    export PATH=\$PATH:\${GOPATH//://bin:}/bin"
echo -e "    export PATH=\$PATH:\${GOROOT//://bin:}/bin"
echo -e "$COL_RESET"
