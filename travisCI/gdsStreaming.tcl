package require openlane
prep -design $::env(DESIGN) -tag config_magic_test 


if { $::env(DIODE_INSERTION_STRATEGY) == 2 } {
    run_magic_antenna_check; # produces a report of violators; extraction!
    heal_antenna_violators; # modifies the routed DEF
}

run_magic
