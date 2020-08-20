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
mkdir pdks
export PDK_ROOT=$(pwd)/pdks
export RUN_ROOT=$(pwd)
echo $PDK_ROOT
echo $RUN_ROOT
export STD_CELL_LIBRARY=sky130_fd_sc_hd
cd  $PDK_ROOT
rm -rf skywater-pdk
git clone https://github.com/google/skywater-pdk.git skywater-pdk
cd skywater-pdk
git checkout -qf 3f310bcc264df0194b9f7e65b83c59759bb27480
git submodule update --init libraries/$STD_CELL_LIBRARY/latest
make $STD_CELL_LIBRARY
cd $PDK_ROOT
rm -rf open_pdks
git clone https://github.com/RTimothyEdwards/open_pdks.git open_pdks
cd open_pdks
git checkout -qf 60b4f62aabff2e4fd9df194b6db59e61a2bd2472
docker run -it -v $RUN_ROOT:/magic_root -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT -u $(id -u $USER):$(id -g $USER) magic:latest  bash -c "sh ./travisCI/buildPDK.sh"
echo "done installing"
cd $RUN_ROOT
exit 0
