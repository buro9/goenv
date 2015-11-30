#!/bin/bash

####
# Change these if you want to
####
DEV_BASE=~/
DEV_DIR=Dev

####
# Don't change anything from this point on
####
DEV_ROOT=${DEV_BASE}${DEV_DIR}/src
mkdir -p ${DEV_ROOT}

ESC_SEQ="\x1b["
COL_RESET=${ESC_SEQ}"39;49;00m"
COL_GREEN=${ESC_SEQ}"32;01m"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  OS=linux
elif [[ "$OSTYPE" == "darwin"* ]]; then
  OS=osx
fi

if [[ ${OS} == "linux" ]]; then
  sudo apt-get update
  sudo apt-get install git
elif [[ ${OS} == "osx" ]]; then
  brew install git
fi

####
# Devenv
####
echo -e "${COL_GREEN}devenv ${COL_RESET}"
cd $DEV_ROOT

REPO_PARENT=${DEV_ROOT}/github.com/buro9
mkdir -p ${REPO_PARENT}

REPO_SRC=git@github.com:buro9/goenv.git
REPO=${REPO_PARENT}/goenv
REPO_VC_DIR=${REPO}/.git
if [ ! -d ${REPO_VC_DIR} ]
then
  git clone ${REPO_SRC} ${REPO}
  cd ${DEV_BASE}${DEV_DIR}
else
  cd ${REPO}
  git pull
fi
