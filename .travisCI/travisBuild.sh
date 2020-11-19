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
git checkout -qf d8e2cf1ba006ed01468aa60e7f4e85a1ece74ca4
git submodule update --init libraries/$STD_CELL_LIBRARY/latest
cnt=0
until make $STD_CELL_LIBRARY; do
cnt=$((cnt+1))
if [ $cnt -eq 5 ]; then
	exit 2
fi
rm -rf skywater-pdk
git clone https://github.com/google/skywater-pdk.git skywater-pdk
cd skywater-pdk
git checkout -qf d8e2cf1ba006ed01468aa60e7f4e85a1ece74ca4
git submodule update --init libraries/$STD_CELL_LIBRARY/latest
done
cd $PDK_ROOT
rm -rf open_pdks
git clone https://github.com/RTimothyEdwards/open_pdks.git open_pdks
cd open_pdks
git checkout -qf 94513d439f76501eacb39701f6e98f3b4f07dcdf
docker run -it -v $RUN_ROOT:/magic_root -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT -u $(id -u $USER):$(id -g $USER) magic:latest  bash -c "sh ./.travisCI/buildPDK.sh"
echo "done installing"
cd $RUN_ROOT
exit 0
