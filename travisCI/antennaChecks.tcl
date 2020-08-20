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

set ::env(OUT_DIR) $::env(test_dir)/antenna
if { ![file isdirectory $::env(OUT_DIR)] } {
	exec mkdir $::env(OUT_DIR)/
}


set magic_export $::env(OUT_DIR)/magic_antenna.tcl
set commands \
"
lef read \$::env(TECH_LEF)
if {  \[info exist ::env(EXTRA_LEFS)\] } {
	set lefs_in \$::env(EXTRA_LEFS)
	foreach lef_file \$lefs_in {
		lef read \$lef_file
	}
}
def read \$::env(CURRENT_DEF)
load \$::env(DESIGN_NAME) -dereference
cd \$::env(OUT_DIR)/
select top cell

# for now, do extraction anyway; can be optimized by reading the maglef ext
# but getting many warnings
if { ! \[file exists \$::env(DESIGN_NAME).ext\] } {
	extract do local
	# extract warn all
	extract
	feedback save $::env(OUT_DIR)/magic_ext2spice.antenna.feedback.txt
}
antennacheck debug
antennacheck
"
	set magic_export_file [open $magic_export w]
		puts $magic_export_file $commands
	close $magic_export_file
	set ::env(PDKPATH) "$::env(PDK_ROOT)/$::env(PDK)/"
	# the following MAGTYPE has to be mag; antennacheck needs to know
	# about the underlying devices, layers, etc.
	set ::env(MAGTYPE) mag
	exec magic \
		-noconsole \
		-dnull \
		-rcfile $::env(MAGIC_MAGICRC) \
		$magic_export \
		</dev/null \
		|& tee /dev/tty $::env(OUT_DIR)/magic_antenna.log

	# process the log
	exec awk "/Cell:/ {print \$2}" $::env(OUT_DIR)/magic_antenna.log \
		> $::env(OUT_DIR)/magic.antenna_violators.rpt
