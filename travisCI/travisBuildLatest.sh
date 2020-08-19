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
make openlane
mkdir pdks
export PDK_ROOT=$(pwd)/pdks
export RUN_ROOT=$(pwd)
echo $PDK_ROOT
echo $RUN_ROOT
cd  $PDK_ROOT
rm -rf skywater-pdk
git clone https://github.com/google/skywater-pdk.git skywater-pdk
cd skywater-pdk
make skywater-library
cd $PDK_ROOT
rm -rf open_pdks
git clone https://github.com/RTimothyEdwards/open_pdks.git open_pdks
cd open_pdks
docker run -it -v $RUN_ROOT:/openLANE_flow -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT -u $(id -u $USER):$(id -g $USER) openlane:rc3  bash -c "make install-open_pdks"
echo "done installing"
cd $RUN_ROOT
exit 0