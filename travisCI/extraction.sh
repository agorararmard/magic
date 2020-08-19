#!/bin/bash
# Copyright 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

export PDK_ROOT=$(pwd)/pdks
export RUN_ROOT=$(pwd)
echo $PDK_ROOT
echo $RUN_ROOT
docker run -it -v $RUN_ROOT:/openLANE_flow -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT -e DESIGN=$DESIGN -u $(id -u $USER):$(id -g $USER) openlane:rc3  bash -c "./flow.tcl -interactive -file /openLANE_flow//travisCI/extraction.tcl"

TEST=$RUN_ROOT/designs/$DESIGN/runs/config_magic_test/results/magic/$DESIGN.ext
BENCHMARK=$RUN_ROOT/designs/$DESIGN/runs/magic_benchmark/results/magic/$DESIGN.ext
crashSignal=$(find $TEST)
if ! [[ $crashSignal ]]; then exit -1; fi
diff -s $TEST $BENCHMARK

exit 0