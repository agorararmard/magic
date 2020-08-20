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
docker run -it -v $RUN_ROOT:/magic_root -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT -e DESIGN=$DESIGN -u $(id -u $USER):$(id -g $USER) magic:latest bash -c "tclsh ./travisCI/extraction.tcl"

test_dir=$RUN_ROOT/testcases/designs/$DESIGN/test/ext

TEST=$test_dir/$DESIGN.ext
BENCHMARK=$RUN_ROOT/testcases/designs/$DESIGN/benchmark/results/$DESIGN.ext

crashSignal=$(find $TEST)
if ! [[ $crashSignal ]]; then echo "Extraction failed"; exit -1; fi

diff -s $TEST $BENCHMARK

echo "[INFO]: Resulting Files:"
ls $test_dir


exit 0
