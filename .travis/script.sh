#!/bin/bash

source .travis/common.sh
set -e

$SPACER

start_section "OpenFPGA.build" "${GREEN}Building..${NC}"
if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
  #make
  mkdir build
  cd build
  cmake .. -DCMAKE_BUILD_TYPE=debug -DENABLE_VPR_GRAPHICS=off
  make -j2
else
# For linux, we enable full package compilation
  #make
  mkdir build
  cd build
  cmake --version
  cmake .. -DCMAKE_BUILD_TYPE=debug
  make -j16
fi
end_section "OpenFPGA.build"

$SPACER

cd -
python3.5 ./openfpga_flow/scripts/run_fpga_task.py basic_flow
