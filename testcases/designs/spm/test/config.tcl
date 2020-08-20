# General config
set ::env(DESIGN_NAME) spm
set ::env(PDK) sky130A
set ::env(STD_CELL_LIBRARY) sky130_fd_sc_hd
set ::env(PDK_ROOT) $::env(PDK_ROOT)
set ::env(CELL_PAD) 8
set ::env(MERGED_LEF) $::env(test_dir)/merged.lef
set ::env(MERGED_LEF_UNPADDED) $::env(test_dir)/merged_unpadded.lef
set ::env(TECH_LEF) $::env(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd.tlef
set ::env(CURRENT_DEF) $::env(test_dir)/spm.def
set ::env(MAGIC_MAGICRC) $::env(test_dir)/.magicrc


