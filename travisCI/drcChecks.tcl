set ::env(PDK) "sky130A"
set ::env(STD_CELL_LIBRARY) "sky130_fd_sc_hd"

set ::env(PDKPATH) "$::env(PDK_ROOT)/$::env(PDK)"
# the following MAGTYPE has to be maglef for the purpose of DRC checking
set ::env(MAGTYPE) maglef

puts_info "Running Magic DRC..."
magic \
    -noconsole \
    -dnull \
    -rcfile $::env(MAGIC_MAGICRC) \
    /magic_root/travisCI/magic_drc.tcl \
    </dev/null \
    |& tee $::env(TERMINAL_OUTPUT) $::env(test_dir)/magic.drc.log
