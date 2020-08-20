#!/usr/bin/tclsh

set ::env(PDK) "sky130A"
set ::env(STD_CELL_LIBRARY) "sky130_fd_sc_hd"

set ::env(PDKPATH) "$::env(PDK_ROOT)/$::env(PDK)"
# the following MAGTYPE has to be maglef for the purpose of DRC checking
set ::env(MAGTYPE) maglef

set ::env(test_dir) /magic_root/testcases/designs/$::env(DESIGN)/test
source $::env(test_dir)/config.tcl

puts "Running Magic DRC..."
exec magic \
    -noconsole \
    -dnull \
    -rcfile $::env(MAGIC_MAGICRC) \
    /magic_root/travisCI/magic_drc1.tcl \
    </dev/null 
