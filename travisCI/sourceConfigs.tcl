#!/usr/bin/tclsh
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

set ::env(PDK) "sky130A"
set ::env(STD_CELL_LIBRARY) "sky130_fd_sc_hd"

set ::env(test_dir) /magic_root/testcases/designs/$::env(DESIGN)/test
source $::env(test_dir)/config.tcl

source $::env(PDK_ROOT)/$::env(PDK)/libs.tech/openlane/

# source PDK and SCL specific configurations
set pdk_config $::env(PDK_ROOT)/$::env(PDK)/libs.tech/openlane/config.tcl
set scl_config $::env(PDK_ROOT)/$::env(PDK)/libs.tech/openlane/$::env(STD_CELL_LIBRARY)/config.tcl
source $pdk_config
source $scl_config

set ::env(PDKPATH) "$::env(PDK_ROOT)/$::env(PDK)"
