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
docker run -it -v $RUN_ROOT:/magic_root -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT -e DESIGN=$DESIGN magic:latest  bash -c "./travisCI/drcChecks.tcl"

TEST=$RUN_ROOT/testcases/designs/$DESIGN/test/magic.drc
crashSignal=$(find $TEST)
if ! [[ $crashSignal ]]; then exit -1; fi

Test_Magic_violations=$(grep "^ [0-9]" $TEST | wc -l)
if ! [[ $Test_Magic_violations ]]; then Test_Magic_violations=-1; fi
if [ $Test_Magic_violations -ne -1 ]; then Test_Magic_violations=$(((Test_Magic_violations+3)/4)); fi

echo $Test_Magic_violations

exit 0
