package require openlane
prep -design $::env(DESIGN) -tag config_magic_test 

run_magic_antenna_check
