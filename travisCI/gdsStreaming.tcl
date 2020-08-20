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

source $::env(MAGIC_ROOT)/travisCI/sourceConfigs.tcl

puts "Streaming out GDS II..."

# the following MAGTYPE better be mag for clean GDS generation
# use load -dereference to ignore it later if needed
set ::env(MAGTYPE) mag
exec mkdir $::env(test_dir)/gds/
exec magic \
    -noconsole \
    -dnull \
    -rcfile $::env(MAGIC_MAGICRC) \
    $::env(MAGIC_ROOT)/travisCI/magic_gds_stream.tcl \
    </dev/null \
    |& tee $::env(TERMINAL_OUTPUT)

